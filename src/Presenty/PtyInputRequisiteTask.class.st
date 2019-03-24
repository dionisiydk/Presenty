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
	action := guide addContinueAction.
	tracker := guide modelManager trackChangesOf: dataField.
	tracker
		on: PtyValueFilled send: #enable to: action;
		on: PtyValueUnfilled send: #disable to: action.
	guide requestUserFor: (tracker createEditorBy: guide)
]

{ #category : #private }
PtyInputRequisiteTask >> dataField: aDataField [
	dataField := aDataField
]
