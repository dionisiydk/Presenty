Class {
	#name : #PtyInputRequisiteTask,
	#superclass : #PtyTask,
	#instVars : [
		'dataField'
	],
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #'instance creation' }
PtyInputRequisiteTask class >> on: dataField [
	^ self new dataField: dataField
]

{ #category : #execution }
PtyInputRequisiteTask >> body [
	| action tracker |
	action := worker addContinueAction.
	tracker := worker modelManager trackChangesOf: dataField.
	tracker
		on: PtyValueFilled send: #enable to: action;
		on: PtyValueUnfilled send: #disable to: action.
	worker requestUserFor: (tracker createEditorBy: worker)
]

{ #category : #private }
PtyInputRequisiteTask >> dataField: aDataField [
	dataField := aDataField
]
