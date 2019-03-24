Class {
	#name : #PtySimpleValuePrinterTests,
	#superclass : #PtyValuePrinterTestCase,
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtySimpleValuePrinterTests >> printerClass [
	^PtySimpleValuePrinter 
]

{ #category : #tests }
PtySimpleValuePrinterTests >> testHasNoneEditDecorator [

	| actual |
	actual := printer editDecorator.
	
	actual should beInstanceOf: PtyNoneEditDecorator 
]

{ #category : #tests }
PtySimpleValuePrinterTests >> testPrinting [

	[:object |
		[(printer printValue: object) should be: #result]
			should strictly satisfy: 
		[object asString willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtySimpleValuePrinterTests >> testPrintingNilValue [

	(printer printValue: nil) should equal: ''.
]
