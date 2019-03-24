Class {
	#name : #PtyFieldDescTests,
	#superclass : #TestCase,
	#instVars : [
		'desc'
	],
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyFieldDescTests >> setUp [ 
	super setUp.
	desc := PtyFieldDesc new.
]

{ #category : #tests }
PtyFieldDescTests >> testCheckingFullValue [
	
	[:valueSpec |
		desc valueSpec: valueSpec.
		
		[(desc isValueFull: #value) should be: #result]
			should strictly satisfy: 
		[(valueSpec isObjectFull: #value) willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyFieldDescTests >> testCheckingValidValue [
	
	[:valueSpec :validationResult |
		desc valueSpec: valueSpec.
		
		[(desc isValueValid: #value) should be: #result]
			should strictly satisfy: 
		[(valueSpec validate: #value) willReturn: validationResult.
		validationResult isSuccess willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyFieldDescTests >> testCreationField [
	
	| field |
	field := desc createField.
	
	field should beInstanceOf: PtyDataField.
	field desc should be: desc
]

{ #category : #tests }
PtyFieldDescTests >> testGettingEditDecorator [
	
	[:valuePrinter | 
		desc valuePrinter: valuePrinter.
		
		[desc editDecorator should be: #result]
			should strictly satisfy: 
		[valuePrinter editDecorator willReturn: #result]
	
	] runWithMocks .

]

{ #category : #tests }
PtyFieldDescTests >> testHasDefaultValueSpec [
	
	desc valueSpec should be: Any
]

{ #category : #tests }
PtyFieldDescTests >> testHasEmptyCommentByDefault [
	
	desc comment should be isEmpty
]

{ #category : #tests }
PtyFieldDescTests >> testHasEmptyDisplayNameByDefault [
	
	desc displayName should be isEmpty
]

{ #category : #tests }
PtyFieldDescTests >> testHasSimpleValuePrinterByDefault [
	
	desc valuePrinter should beInstanceOf: PtySimpleValuePrinter 
]

{ #category : #tests }
PtyFieldDescTests >> testPrintingFieldValue [
	
	[:valuePrinter | 
		desc valuePrinter: valuePrinter.
		
		[(desc printFieldValue: #value) should be: #result]
			should strictly satisfy: 
		[(valuePrinter printValue: #value) willReturn: #result]
	
	] runWithMocks .

]
