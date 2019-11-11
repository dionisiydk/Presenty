Class {
	#name : #PtyInputRequisitiesTask,
	#superclass : #PtyItemsListTask,
	#instVars : [
		'editTask',
		'submitButton',
		'nextFieldButton',
		'editors',
		'selectionFactory'
	],
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #execution }
PtyInputRequisitiesTask >> body [

	announcer unsubscribe: self.
	editTask := nil.
	announcer on: PtyInputLeftRequested send: #selectNextField to: self.
	announcer on: PtyInputFocused send: #itemSelected: to: self.	
	announcer on: PtyValueChanged send: #valueChanged to: self.
	announcer on: PtyInputSubmitted send: #submitInput to: self.
	
	editors := items collect: [:each | each createEditorBy: workplace].

	workplace addTask: [
		user execute: [self requestButtonsInput]
	].

	editTask := user select: PtyActiveDataModel from: editors.

	user execute: editTask
]

{ #category : #'initialize-release' }
PtyInputRequisitiesTask >> initialize [ 
	super initialize.
	submitButton :=  PtyPresentersDecorator named: 'button' withStyle: #submitButton.
	submitButton addUserAction: [self submitInput].
	nextFieldButton := PtyPresentersDecorator named: 'button' withStyle: #nextFieldButton.
	nextFieldButton addUserAction: [self selectNextInvalidField]
	
]

{ #category : #execution }
PtyInputRequisitiesTask >> inputSubmitted [

	(items allSatisfy: [:each | each isValid]) 
		ifTrue: [submitButton model value]
]

{ #category : #execution }
PtyInputRequisitiesTask >> itemSelected: anInputFocused [

	self selectRequisite: anInputFocused input model
]

{ #category : #execution }
PtyInputRequisitiesTask >> requestButtonsInput [

		(items allSatisfy: [:each | each isValid]) 
				ifTrue: [workplace show: submitButton]
				ifFalse: [
					items size > 1 
						ifTrue: [workplace show: nextFieldButton]
						ifFalse: [submitButton view ifNotNilDo: [:v | v delete]]					
					]
	
]

{ #category : #execution }
PtyInputRequisitiesTask >> selectNextField [

	| next |
	next := (items copyAfter: editTask requisite) detect: [:each | each isValid not] ifNone: [nil].
	next ifNil: [
		next := items detect: [:each | each isValid not] ifNone: [^self].
	].	

	self selectRequisite: next
]

{ #category : #execution }
PtyInputRequisitiesTask >> selectNextFieldIfNeeded [

	(items allSatisfy: [:each | each isValid])
		ifTrue: [^self].

	editTask ifNil: [^self].
	
	editTask requisite isFull ifTrue: [			
		self selectNextInvalidField].
	
]

{ #category : #execution }
PtyInputRequisitiesTask >> selectNextInvalidField [

	| next |
	
	next := (items copyAfter: editTask requisite) detect: [:each | each isValid not] ifNone: [nil].
	next ifNil: [
		next := items detect: [:each | each isValid not] ifNone: [^self].
	].	

	self selectRequisite: next
]

{ #category : #execution }
PtyInputRequisitiesTask >> selectRequisite: aDataField [

	selectionFactory selectItem: (items indexOf: aDataField) .
]

{ #category : #execution }
PtyInputRequisitiesTask >> submitInput [

	(items allSatisfy: [:each | each isValid]) 
		ifFalse: [^self].
	
	workplace restoreActiveArea.
	"guide controller uiActions reset."
	workplace resumeTask: context with: true
]

{ #category : #execution }
PtyInputRequisitiesTask >> valueChanged [

	self selectNextFieldIfNeeded.
	
	"guide restoreActiveArea."
	self requestButtonsInput 
]
