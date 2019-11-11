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
	action := workplace addContinueAction.
	tracker := workplace modelManager trackChangesOf: dataField.
	tracker
		on: PtyValueFilled send: #enable to: action;
		on: PtyValueUnfilled send: #disable to: action.
	workplace requestUserFor: (tracker createEditorBy: workplace)
]

{ #category : #private }
PtyInputRequisiteTask >> dataField: aDataField [
	dataField := aDataField
]
