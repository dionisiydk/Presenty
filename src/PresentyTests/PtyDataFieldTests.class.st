Class {
	#name : #PtyDataFieldTests,
	#superclass : #TestCase,
	#instVars : [
		'field',
		'desc',
		'type',
		'data'
	],
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyDataFieldTests >> setUp [
	super setUp.

	data := Mock new.
	desc := Mock new.
	field := PtyDataField desc: desc.
	field data: data.
	
]

{ #category : #tests }
PtyDataFieldTests >> testBecomingActive [

	field data: #fieldData.
	
	field becomeActive.
	
	field data should beInstanceOf: PtyActiveDataModel.
	field data data should be: #fieldData
]

{ #category : #tests }
PtyDataFieldTests >> testCheckingFull [

	[
		[field isFull should be: #result]
			should strictly satisfy: 
		[data value willReturn: #value.
		(desc isValueFull: #value) willReturn: #result]	
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testCheckingValid [

	[
		[field isValid should be: #result]
			should strictly satisfy: 
		[data value willReturn: #value.
		(desc isValueValid: #value) willReturn: #result]	
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testGettingEditDecorator [

	[ 
		[field editDecorator should be: #result]
			should strictly satisfy: 
		[desc editDecorator willReturn: #result]
		
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testGettingValue [

	[ 
		[field value should be: #result]
			should strictly satisfy: 
		[data value willReturn: #result]
		
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testGettingValuePreviewPresenter [

	[:fieldValue |
	
		[field valuePreviewPresenter should be: #result]
			should strictly satisfy: 
		[data value willReturn: fieldValue.
		(fieldValue previewPresenterForFieldWith: desc) willReturn: #result]
		
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testGettingValueSpec [

	[ 
		[field valueSpec should be: #result]
			should strictly satisfy: 
		[desc valueSpec willReturn: #result]
		
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testGettingValueWhenItAbsent [

	[ 
		[field value should be: #defaultValue]
			should strictly satisfy: 
		[data value willReturn: nil.
		desc defaultValue willReturn: #defaultValue.
		data value: #defaultValue]
		
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testGettingValueWhenItAbsentAndDefaultValueToo [

	[ 
		[field value should be: nil]
			should strictly satisfy: 
		[data value willReturn: nil.
		desc defaultValue willReturn: nil]
		
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testHasDataByDefault [

	field := PtyDataField new.
	
	field data should beInstanceOf: PtyValueHolder
]

{ #category : #tests }
PtyDataFieldTests >> testPrintingValue [

	[	
		[field printValue should be: #printedValue]
			should lenient satisfy: 
		[data value willReturn: #value.
		(desc printFieldValue: #value) willReturn: #printedValue]	
	] runWithMocks 
]

{ #category : #tests }
PtyDataFieldTests >> testSettingValue [

	[:data | 
		field data: data.
		
		[field value: #newValue]
			should strictly satisfy: 
		[data value: #newValue]
		
	] runWithMocks 
]
