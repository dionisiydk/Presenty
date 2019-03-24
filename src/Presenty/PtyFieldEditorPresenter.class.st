Class {
	#name : #PtyFieldEditorPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'input',
		'focusRequired',
		'textConverter',
		'textSpec'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #presentation }
PtyFieldEditorPresenter >> addTextInputAction [
	| inputTool |
	inputTool := PtyPasteCharsUserAction new.
	inputTool editor: input.
	self addUserAction: inputTool
]

{ #category : #presentation }
PtyFieldEditorPresenter >> createViewItems [
	super createViewItems.
	
	input := PtyTextInputPresenter on: model withStyle: self inputStyle.
	input textConverter: textConverter.
	input textSpec: textSpec.
	self hookupView
]

{ #category : #presentation }
PtyFieldEditorPresenter >> focus [
	input ifNotNil: [input focus].
	focusRequired := false
]

{ #category : #accessing }
PtyFieldEditorPresenter >> focusRequired [ 
	^focusRequired ifNil: [false]
]

{ #category : #accessing }
PtyFieldEditorPresenter >> focusRequired: anObject [
	focusRequired := anObject
]

{ #category : #presentation }
PtyFieldEditorPresenter >> focusSilently [  
	view ifNil: [^self].
	
	self unhookView .
	[self focus] ensure: [self hookupView]. 
]

{ #category : #'events handling' }
PtyFieldEditorPresenter >> focused [

	self announce: (PtyInputFocused input: self)
]

{ #category : #private }
PtyFieldEditorPresenter >> hookupModel [

	model on: PtyValueChanged send: #valueChanged to: self
]

{ #category : #presentation }
PtyFieldEditorPresenter >> hookupView [
	input on: PtyInputComplete, PtyInputSubmitted, PtyInputLeftRequested send: #announce: to: self.
	input on: PtyInputFocused send: #focused to: self
]

{ #category : #'initialize-release' }
PtyFieldEditorPresenter >> initialize [ 
	super initialize.
	
	focusRequired := false.
	self addTextInputAction
]

{ #category : #accessing }
PtyFieldEditorPresenter >> input [
	^ input
]

{ #category : #accessing }
PtyFieldEditorPresenter >> input: anObject [
	input := anObject
]

{ #category : #accessing }
PtyFieldEditorPresenter >> inputStyle [
	
	^model isValid ifTrue: [#filled] ifFalse: [^#unfilled].
]

{ #category : #presentation }
PtyFieldEditorPresenter >> inputTool [
	
	| inputTool |
	inputTool := model valueValidator inputTool.
	inputTool inputField: self.
	^ inputTool
]

{ #category : #presentation }
PtyFieldEditorPresenter >> showInputOn: aPanel [
	
	self showItem: input on: aPanel	
	
]

{ #category : #presentation }
PtyFieldEditorPresenter >> showViewItems [ 

	self showItem: (PtyLabelPresenter textNamed: model desc displayName withStyle: #fieldName)
		on: 'fieldName'.
	
	self showInputOn: 'input'.
	
	self showItem: (PtyLabelPresenter textNamed: model desc comment withStyle: #fieldComment)
		on: 'fieldComment'.

	view on: #mouseDown send: #focus to: self.
	self takeFocusIfNeeded
]

{ #category : #presentation }
PtyFieldEditorPresenter >> takeFocusIfNeeded [

	self focusRequired ifTrue: [self focusSilently]
]

{ #category : #accessing }
PtyFieldEditorPresenter >> textConverter [
	^ textConverter
]

{ #category : #accessing }
PtyFieldEditorPresenter >> textConverter: anObject [
	textConverter := anObject
]

{ #category : #accessing }
PtyFieldEditorPresenter >> textSpec [
	^ textSpec
]

{ #category : #accessing }
PtyFieldEditorPresenter >> textSpec: spec [
	textSpec := spec
]

{ #category : #private }
PtyFieldEditorPresenter >> unhookModel [
	super unhookModel.
	input ifNotNil: [input unhookModel].
	model unsubscribe: self
]

{ #category : #presentation }
PtyFieldEditorPresenter >> unhookView [
	input unsubscribe: self
]

{ #category : #'events handling' }
PtyFieldEditorPresenter >> valueChanged [

	self announce: PtyValueChanged.

	model isValid 
		ifTrue: [self announce: PtyValueFilled]
		ifFalse: [self announce: PtyValueUnfilled].
	
	guide show: input withStyle: self inputStyle.

	model isFull ifTrue: [self announce: PtyInputComplete]
]
