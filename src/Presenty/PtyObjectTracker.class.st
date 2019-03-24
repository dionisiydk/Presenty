Class {
	#name : #PtyObjectTracker,
	#superclass : #Announcer,
	#instVars : [
		'dataField'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #'instance creation' }
PtyObjectTracker class >> for: dataField [ 
	^ self new dataField: dataField
]

{ #category : #presentation }
PtyObjectTracker >> createEditorBy: aGuide [
	^ dataField desc createEditorFor: self by: aGuide
]

{ #category : #private }
PtyObjectTracker >> dataField: aDataField [ 
	dataField := aDataField
]

{ #category : #dispatching }
PtyObjectTracker >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: dataField
]

{ #category : #dispatching }
PtyObjectTracker >> value: value [
	| prevState |
	prevState := dataField isValid.
	dataField value: value.
	self announce: PtyValueChanged.
	prevState = dataField isValid
		ifTrue: [ ^ self ].
	dataField isValid
		ifTrue: [ self announce: PtyValueFilled ]
		ifFalse: [ self announce: PtyValueUnfilled ]
]
