Class {
	#name : #PtyValuePrinterTestCase,
	#superclass : #TestCase,
	#instVars : [
		'printer'
	],
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #testing }
PtyValuePrinterTestCase class >> isAbstract [ 
	^self == PtyValuePrinterTestCase
]

{ #category : #running }
PtyValuePrinterTestCase >> printerClass [ 
	self subclassResponsibility 
]

{ #category : #running }
PtyValuePrinterTestCase >> setUp [ 
	super setUp.
	
	printer := self printerClass new
]

{ #category : #tests }
PtyValuePrinterTestCase >> testConvertingToMaskedPrinter [

	| actual |
	actual := printer asMaskedWith: #mask.
	
	actual should beInstanceOf: PtyCompositePrinter.
	actual printers first should be: printer.
	actual printers last should beInstanceOf: PtyMaskedValuePrinter.
	actual printers last mask should be: #mask
]

{ #category : #tests }
PtyValuePrinterTestCase >> testConvertingToSecretePrinter [

	| actual |
	actual := printer asSecrete.
	
	actual should beInstanceOf: PtyCompositePrinter.
	actual printers first should be: printer.
	actual printers last should beInstanceOf: PtySecreteValuePrinter
]
