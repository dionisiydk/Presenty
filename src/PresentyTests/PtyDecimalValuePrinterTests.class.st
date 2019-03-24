Class {
	#name : #PtyDecimalValuePrinterTests,
	#superclass : #PtyValuePrinterTestCase,
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyDecimalValuePrinterTests >> printerClass [

	^PtyDecimalValuePrinter 
]

{ #category : #tests }
PtyDecimalValuePrinterTests >> testHasNoneEditDecorator [

	| actual |
	
	actual := printer editDecorator.
	
	actual should beInstanceOf: PtyNoneEditDecorator.
	

]

{ #category : #tests }
PtyDecimalValuePrinterTests >> testHasZeroDecimalDigitsByDefault [

	printer decimalDigitsCount should be: 0

	
]

{ #category : #tests }
PtyDecimalValuePrinterTests >> testPrintingFloatWithDecimalDigits [

	| actual |
	printer decimalDigitsCount: 2.
	
	actual := printer printValue: 123.456.
	
	actual should equal: '123.46'

	
]

{ #category : #tests }
PtyDecimalValuePrinterTests >> testPrintingFloatWithoutDecimalDigits [

	| actual |
	printer decimalDigitsCount: 0.
	
	actual := printer printValue: 123.45.
	
	actual should equal: '123'

	
]

{ #category : #tests }
PtyDecimalValuePrinterTests >> testPrintingIntegerWithDecimalDigits [

	| actual |
	printer decimalDigitsCount: 2.
	
	actual := printer printValue: 123.
	
	actual should equal: '123.00'

	
]

{ #category : #tests }
PtyDecimalValuePrinterTests >> testPrintingIntegerWithoutDecimalDigits [

	| actual |
	printer decimalDigitsCount: 0.
	
	actual := printer printValue: 123.
	
	actual should equal: '123'

	
]

{ #category : #tests }
PtyDecimalValuePrinterTests >> testPrintingNilValue [

	(printer printValue: nil) should equal: ''.
]
