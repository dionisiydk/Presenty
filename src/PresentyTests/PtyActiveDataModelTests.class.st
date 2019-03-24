Class {
	#name : #PtyActiveDataModelTests,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'field'
	],
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyActiveDataModelTests >> setUp [
	super setUp.
	
	field := Mock new.
	model := PtyActiveDataModel on: field.
]

{ #category : #tests }
PtyActiveDataModelTests >> testGettingValue [

	[[model value should be: #value]
		should lenient satisfy:
	[field value willReturn: #value]
	] runWithMocks 
]

{ #category : #tests }
PtyActiveDataModelTests >> testSettingValue [

	| announced |
	model on: PtyValueChanged do: [:ann | announced := true].
	
	[[model value: #value]
		should lenient satisfy:
	[field value: #value]
	] runWithMocks .

	announced should be: true
]
