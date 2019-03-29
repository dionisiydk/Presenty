Class {
	#name : #PtyEditRequisiteNewTask,
	#superclass : #PtyTask,
	#instVars : [
		'requisite',
		'model',
		'presenter'
	],
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #accessing }
PtyEditRequisiteNewTask class >> createPreferredInstanceBy: aTaskPrototypeFactory [

	^aTaskPrototypeFactory preferredEditTextTask
]

{ #category : #'instance creation' }
PtyEditRequisiteNewTask class >> for: aDataField [

	^self new requisite: aDataField 

]

{ #category : #execution }
PtyEditRequisiteNewTask >> body [ 

	user lookAt: [
		worker showViewArea.
		presenter focusSilently]
]

{ #category : #accessing }
PtyEditRequisiteNewTask >> createPresenter [ 

	presenter := PtyFieldEditorPresenter on: model
]

{ #category : #accessing }
PtyEditRequisiteNewTask >> model [
	^ model
]

{ #category : #accessing }
PtyEditRequisiteNewTask >> model: anObject [
	model := anObject
]

{ #category : #accessing }
PtyEditRequisiteNewTask >> preferredPreviewPresenter [ 

	^presenter
]

{ #category : #accessing }
PtyEditRequisiteNewTask >> prepareRequisite: aDataField [ 

	requisite := aDataField.
	model := requisite 

]

{ #category : #accessing }
PtyEditRequisiteNewTask >> presenter [
	^ presenter
]

{ #category : #accessing }
PtyEditRequisiteNewTask >> presenter: anObject [
	presenter := anObject
]

{ #category : #accessing }
PtyEditRequisiteNewTask >> requisite [
	^ requisite
]

{ #category : #accessing }
PtyEditRequisiteNewTask >> requisite: anObject [
	requisite := anObject
]
