Class {
	#name : #PtyTextInputMorph,
	#superclass : #PtyTextMorph,
	#instVars : [
		'announcer',
		'editDecorator',
		'textConverter',
		'needsCaret',
		'isFocused',
		'needsAutoSelection',
		'valueSpec'
	],
	#category : #'Presenty-UI'
}

{ #category : #menu }
PtyTextInputMorph >> addCustomMenuItems: aCustomMenu hand: aHandMorph [

	super addCustomMenuItems: aCustomMenu hand: aHandMorph.
	
	aCustomMenu
		addToggle: 'needs caret' translated
		target:  self
		selector: #needsCaret:
		getStateSelector:  #needsCaret
		argumentList: {needsCaret not}.
	aCustomMenu
		addToggle: 'needs auto selection' translated
		target:  self
		selector: #needsAutoSelection:
		getStateSelector:  #needsAutoSelection
		argumentList: {self needsAutoSelection not}.
]

{ #category : #private }
PtyTextInputMorph >> alignText [
	editor selectInvisiblyFrom: 1 to: editor string size.
	editor applyAttribute: (TextAlignment perform: textAlignment).
	editor selectAt: editDecorator cursorPosition
]

{ #category : #accessing }
PtyTextInputMorph >> announcer [
	^ announcer
]

{ #category : #accessing }
PtyTextInputMorph >> announcer: anObject [
	announcer := anObject
]

{ #category : #copying }
PtyTextInputMorph >> cleanupYourselfForPrototype [ 
	super cleanupYourselfForPrototype.
	announcer := Announcer new.
	editor := nil
]

{ #category : #copying }
PtyTextInputMorph >> collectOwnCopyPreventedResourcesTo: aCollection [ 
	super collectOwnCopyPreventedResourcesTo: aCollection.
	aCollection add: announcer.

]

{ #category : #private }
PtyTextInputMorph >> decorate: newValue at: newPoint oldValue: oldValue at: oldPoint [
	| pastedChars newCharsCount deletedChars editInfo value |

	editInfo := PtyEditStringInfo on: oldValue.
	editInfo computeFor: newValue newPosition: newPoint.
	editInfo hasDeleted ifTrue: [
		editDecorator clearCharsBack: editInfo deleted size startingAt: editInfo deleteEnd].
	editInfo hasPasted ifTrue: [
		pastedChars := editInfo pasted.
		editDecorator insertChars: pastedChars at: editInfo editStart.
		
		(textConverter canConvertString: editDecorator nativeValue) ifTrue: [
			value := textConverter readValueFrom: editDecorator nativeValue.
			(valueSpec validate: value) isSuccess ifTrue: [^self].
		].
		
		editDecorator decoratedValue: oldValue.	
		editDecorator cursorPosition: oldPoint.
		
].

]

{ #category : #accessing }
PtyTextInputMorph >> editDecorator [
	^ editDecorator
]

{ #category : #accessing }
PtyTextInputMorph >> editDecorator: anEditDecorator [
	editDecorator := anEditDecorator 
]

{ #category : #accessing }
PtyTextInputMorph >> focus [

	self isFocused ifTrue: [^self].
	
	self focusSilently.	
	self needsAutoSelection ifTrue: [editor selectAll].
	
	announcer announce: (PtyInputFocused input: self).
]

{ #category : #accessing }
PtyTextInputMorph >> focusSilently [

	self takeKeyboardFocus.
		 
	isFocused := true
	
]

{ #category : #testing }
PtyTextInputMorph >> handleKeystroke: evt [

	evt keyCharacter = Character cr ifTrue: [
		announcer announce: PtyInputSubmitted.		
		^false].
	evt keyCharacter = Character tab ifTrue: [
		announcer announce: PtyInputLeftRequested.		
		^false].

	^super handleKeystroke: evt
]

{ #category : #initialization }
PtyTextInputMorph >> initialize [ 
	super initialize.	
	announcer := Announcer new.
	self cornerStyle: #rounded.
	valueSpec := Any.
	editDecorator := PtyNoneEditDecorator new.	
	textConverter := PtyNoneTextConverter new.
	needsCaret := true.
	needsAutoSelection := false.
	super newContents:  editDecorator decoratedValue.	
	
]

{ #category : #accessing }
PtyTextInputMorph >> isFocused [

	^isFocused ifNil: [false]
]

{ #category : #'event handling-override' }
PtyTextInputMorph >> keyStroke: evt [
	| oldPoint newPoint newValue oldValue |
	oldPoint := editor pointIndex.
	oldValue := self contents asString.
	
	super keyStroke: evt.
	
	newPoint := editor pointIndex.
	newValue := self contents asString.
	oldValue = newValue
		ifTrue: [ ^ self ].
	self
		decorate: newValue
		at: newPoint
		oldValue: oldValue
		at: oldPoint.
	self updateText.
	
	oldValue = self contents asString ifFalse: [self valueChanged]

	
	
]

{ #category : #'event handling-override' }
PtyTextInputMorph >> keyboardFocusChange: aBoolean [

	super keyboardFocusChange: aBoolean.
	isFocused := false
]

{ #category : #'event handling-override' }
PtyTextInputMorph >> mouseDown: evt [

	super mouseDown: evt.
	self focus
]

{ #category : #accessing }
PtyTextInputMorph >> nativeContents [
	^editDecorator nativeValue.
]

{ #category : #accessing }
PtyTextInputMorph >> needsAutoSelection [
	^ needsAutoSelection ifNil: [false]
]

{ #category : #accessing }
PtyTextInputMorph >> needsAutoSelection: anObject [
	needsAutoSelection := anObject
]

{ #category : #accessing }
PtyTextInputMorph >> needsCaret [
	^needsCaret ifNil: [needsCaret := true]
]

{ #category : #accessing }
PtyTextInputMorph >> needsCaret: aBoolean [
	needsCaret := aBoolean
]

{ #category : #accessing }
PtyTextInputMorph >> newContents: aString [

	| oldValue value |
	oldValue := self contents asString.

	(textConverter canConvertString: aString) ifFalse: [^false].
	value := textConverter readValueFrom: aString.
	(valueSpec validate: value) isFailing ifTrue: [^self].
	
	editDecorator decorate: aString.
	super newContents: editDecorator decoratedValue.
	
	oldValue = self contents asString ifFalse: [self valueChanged].
	


]

{ #category : #accessing }
PtyTextInputMorph >> setContentsSilently: aString [

	editDecorator decoratedValue: aString.
	super newContents: editDecorator decoratedValue.
	

]

{ #category : #accessing }
PtyTextInputMorph >> textConverter [
	^ textConverter
]

{ #category : #accessing }
PtyTextInputMorph >> textConverter: anObject [
	textConverter := anObject
]

{ #category : #private }
PtyTextInputMorph >> updateText [
	editor
		replace: (1 to: self contents size)
		with: editDecorator decoratedValue
		and: [ 
			editor selectAt: editDecorator cursorPosition.
			self needsCaret
				ifFalse: [ 
					self paragraph showCaret: false.
					self paragraph caretRect ifNotNil: [ :r | self invalidRect: r ] ] ].
	self alignText
]

{ #category : #'event handling-override' }
PtyTextInputMorph >> valueChanged [
	announcer announce: PtyValueChanged
]

{ #category : #accessing }
PtyTextInputMorph >> valueSpec [
	^ valueSpec
]

{ #category : #accessing }
PtyTextInputMorph >> valueSpec: anObject [
	valueSpec := anObject
]

{ #category : #testing }
PtyTextInputMorph >> wantsKeyboardFocusNavigation [
	"Answer whether the receiver wants to be navigated to"

	^true
]

{ #category : #testing }
PtyTextInputMorph >> wouldAcceptKeyboardFocusUponTab [
	"Answer whether the receiver might accept keyboard focus if 
	tab were hit in some container playfield"
	^false
]
