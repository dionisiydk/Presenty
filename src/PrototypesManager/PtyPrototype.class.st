Class {
	#name : #PtyPrototype,
	#superclass : #Object,
	#instVars : [
		'collection',
		'sample',
		'prototypeClass'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyPrototype class >> in: aPrototypesCollection [
	^self new 
		collection: aPrototypesCollection  
]

{ #category : #'instance creation' }
PtyPrototype class >> sample: anObject [

	^self new 
		sample: anObject 
]

{ #category : #'instance creation' }
PtyPrototype class >> sample: anObject class: aPrototypeClass [ 

	^self new 
		sample: anObject;
		prototypeClass: aPrototypeClass 
]

{ #category : #accessing }
PtyPrototype >> addToContextOf: aPrototypesLookup [
	| parentLookup targetCollection |
	targetCollection := nil.	
	parentLookup := aPrototypesLookup.
	
	[parentLookup isNil or: [targetCollection notNil]]
		whileFalse: [
			targetCollection := (collection includedToParentAt: parentLookup context)
				ifTrue: [collection] ifFalse: [collection findParentWhichBelongsTo: parentLookup context].
			parentLookup := parentLookup parentContextLookup].
	
	targetCollection ifNil: [targetCollection := collection root].
	
	^targetCollection add: self to: aPrototypesLookup context
]

{ #category : #accessing }
PtyPrototype >> addToContextOf: aPrototypesLookup and: somePrototypeConsumer [ 

	| newPrototype |
	(self belongsTo: aPrototypesLookup context) ifTrue: [^self].
	
	newPrototype := self addToContextOf: aPrototypesLookup.
	somePrototypeConsumer prototype: newPrototype
]

{ #category : #accessing }
PtyPrototype >> anotherPrototypeClasses [ 
 
	^prototypeClass possiblePrototypeClasses copyWithout: sample class


]

{ #category : #accessing }
PtyPrototype >> assignToCollection [

	collection defaultPrototype: self
]

{ #category : #testing }
PtyPrototype >> belongsTo: aPrototypeContext [ 
	^collection belongsTo: aPrototypeContext 
]

{ #category : #testing }
PtyPrototype >> belongsToContextOf: aPrototypesLookup and: somePrototypeConsumer [

	^self belongsTo: aPrototypesLookup context
]

{ #category : #accessing }
PtyPrototype >> collection [
	^ collection
]

{ #category : #accessing }
PtyPrototype >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
PtyPrototype >> createCopy [
	^PtyPrototype sample: sample copyAsPrototype class: prototypeClass 
]

{ #category : #accessing }
PtyPrototype >> delete [

	collection removeDefaultPrototype.
	collection delete.
	
	
]

{ #category : #'morphic menu' }
PtyPrototype >> deleteWithUserRequestFrom: somePrototypeConsumer [ 

	| answer |
	self isAssigned ifFalse: [	
		self error: 'Not assiged prototype cant be removed!'].
	
	answer := UIManager default confirm: 'Do you want remove ', somePrototypeConsumer prototypeContextName, '?'.
	answer ifFalse: [^self].
	
	self delete
]

{ #category : #testing }
PtyPrototype >> isAssigned [
	^collection defaultPrototype == self
]

{ #category : #accessing }
PtyPrototype >> newInstance [
	^sample copyAsNewInstance 
]

{ #category : #'morphic menu' }
PtyPrototype >> populateAnotherPrototypesMenu: aMenu [

	| anotherClasses subMenu |
	
	prototypeClass ifNil: [^self].
	
	anotherClasses := self anotherPrototypeClasses.

	anotherClasses ifEmpty: [^self].
		
	subMenu := MenuMorph new defaultTarget: self.

	anotherClasses do: [:each | 
		subMenu 
			add: each name
			target: (self proxyForSample: self)
			selector: #useSampleOf: 
			argumentList: {each}.
	].

	aMenu add: 'select another class' translated subMenu: subMenu
]

{ #category : #'morphic menu' }
PtyPrototype >> populateContextsMenu: aMenu by: aPrototypesManager for: somePrototypeConsumer [

	| subMenu lookupGroups |

	lookupGroups := aPrototypesManager contextGroupsFor: somePrototypeConsumer.

	lookupGroups do: [:eachGroup | | baseContext lookupArrays | 
		baseContext := eachGroup key.
		lookupArrays := eachGroup value.
		subMenu := MenuMorph new defaultTarget: self.
		lookupArrays do: [:each |
			subMenu 
				addToggle: each context printName
				target:  self
				selector: #addToContextOf:and:
				getStateSelector:  #belongsToContextOf:and:
				argumentList: {each. somePrototypeConsumer}].
	
		aMenu add: baseContext contextClass name subMenu: subMenu
	].
	
		
]

{ #category : #'morphic menu' }
PtyPrototype >> populateMenu: aMenu by: aPrototypesManager for: somePrototypeConsumer [

	somePrototypeConsumer populatePrototypeConsumerMenu: aMenu.

	aMenu addLine.
	
	self populateContextsMenu: aMenu by: aPrototypesManager for: somePrototypeConsumer.	
	
	aMenu add: 'remove prototype' translated 
		target: self	selector: #deleteWithUserRequestFrom: argumentList: {somePrototypeConsumer}.
	
	aMenu addLine.
	
	self populateAnotherPrototypesMenu: aMenu.
	
	sample populateSettingsMenu: aMenu for: self.
]

{ #category : #accessing }
PtyPrototype >> prototypeClass [
	^ prototypeClass
]

{ #category : #accessing }
PtyPrototype >> prototypeClass: anObject [
	prototypeClass := anObject
]

{ #category : #'morphic menu' }
PtyPrototype >> proxyForSample: anObject [
	^PtyPrototypeSampleProxy on: self for: anObject 
]

{ #category : #accessing }
PtyPrototype >> sample [
	^ sample
]

{ #category : #accessing }
PtyPrototype >> sample: anObject [
	sample := anObject
]

{ #category : #accessing }
PtyPrototype >> sampleClass [

	^sample class
]

{ #category : #accessing }
PtyPrototype >> saveNewSample: newSampleObject [

	sample := newSampleObject copyAsPrototype.
	
	collection defaultPrototype: self	
]

{ #category : #accessing }
PtyPrototype >> useSampleOf: aClass [

	sample := aClass new.
]
