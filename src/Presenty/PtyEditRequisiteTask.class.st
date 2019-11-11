Class {
	#name : #PtyEditRequisiteTask,
	#superclass : #PtyTask,
	#instVars : [
		'requisite',
		'input'
	],
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #accessing }
PtyEditRequisiteTask class >> createPreferredInstanceBy: aTaskPrototypeFactory [

	^aTaskPrototypeFactory preferredFieldEditorTask
]

{ #category : #'instance creation' }
PtyEditRequisiteTask class >> on: aFieldModel [
	self subclassResponsibility
]

{ #category : #execution }
PtyEditRequisiteTask >> body [ 

	self createInput.
	
	user execute: [workplace showViewArea. input focus].
	
	context resumeWith: nil.
	
	
]

{ #category : #execution }
PtyEditRequisiteTask >> createInput [

	input := PtyFieldEditorPresenter on: requisite.	
	input on: PtyInputComplete, PtyInputSubmitted, PtyInputLeftRequested send: #announce: to: self.
	input on: PtyValueChanged send: #valueChanged to: self.
	workplace add: input toViewAreaOn: (name ifNil: ['editor']).	
	
]

{ #category : #accessing }
PtyEditRequisiteTask >> requisite [
	^ requisite
]

{ #category : #accessing }
PtyEditRequisiteTask >> requisite: anObject [
	requisite := anObject
]

{ #category : #accessing }
PtyEditRequisiteTask >> unhookInput [ 
	
	input unsubscribe: self
]

{ #category : #execution }
PtyEditRequisiteTask >> valueChanged [

	input answer: nil
]
