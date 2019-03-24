Class {
	#name : #PtyCompositePrinterTests,
	#superclass : #PtyValuePrinterTestCase,
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyCompositePrinterTests >> printerClass [
	^PtyCompositePrinter 
]

{ #category : #tests }
PtyCompositePrinterTests >> testHasEditDecoratorFromLastPrinter [

	[:printer1 :printer2 |
		printer printers: {printer1. printer2}.
		
		[printer editDecorator should be: #result]
			should strictly satisfy: 
		[printer2 editDecorator willReturn: #result]
		
	] runWithMocks 
]

{ #category : #tests }
PtyCompositePrinterTests >> testHasEmptyPrintersByDefault [

	printer printers should be isEmpty
]

{ #category : #tests }
PtyCompositePrinterTests >> testPrintingValue [

	[:printer1 :printer2 |
		printer printers: {printer1. printer2}.
		
		[(printer printValue: #value) should be: #printedValue2]
			should strictly satisfy: 
		[(printer1 printValue: #value) willReturn: #printedValue1.
		(printer2 printValue: #printedValue1) willReturn: #printedValue2]
		
	] runWithMocks 
]
