Class {
	#name : #PtySecreteValuePrinterTests,
	#superclass : #PtyValuePrinterTestCase,
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtySecreteValuePrinterTests >> printerClass [

	^PtySecreteValuePrinter 
]

{ #category : #tests }
PtySecreteValuePrinterTests >> testHasNoneEditDecorator [

	printer editDecorator should beInstanceOf: PtySecreteEditDecorator 
]

{ #category : #tests }
PtySecreteValuePrinterTests >> testHasSecreteCharByDefault [

	printer secreteChar should beInstanceOf: Character 
]

{ #category : #tests }
PtySecreteValuePrinterTests >> testPrintingNilValue [

	(printer printValue: nil) should equal: ''.
]

{ #category : #tests }
PtySecreteValuePrinterTests >> testPrintingStringWhenSecreteMaskExists [

	| actual |
	printer secreteChar: $*.
	printer secreteMask: 'x**xx'.
	
	actual := printer printValue: '12345'.
	
	actual should equal: '1**45'
	
]

{ #category : #tests }
PtySecreteValuePrinterTests >> testPrintingStringWhenSecreteMaskTooBig [

	| actual |
	printer secreteChar: $*.
	printer secreteMask: 'x**xx****'.
	
	actual := printer printValue: '12345'.
	
	actual should equal: '1**45'
	
]

{ #category : #tests }
PtySecreteValuePrinterTests >> testPrintingStringWhenSecreteMaskTooBig2 [

	| actual |
	printer secreteChar: $*.
	printer secreteMask: 'x**xx*xxxx*'.
	
	actual := printer printValue: '12345'.
	
	actual should equal: '1**45'
	
]

{ #category : #tests }
PtySecreteValuePrinterTests >> testPrintingStringWhenSecreteMaskTooLittle [

	| actual |
	printer secreteChar: $*.
	printer secreteMask: 'x**'.
	
	actual := printer printValue: '12345'.
	
	actual should equal: '1****'
	
]

{ #category : #tests }
PtySecreteValuePrinterTests >> testPrintingStringWithoutSecreteMask [

	| actual |
	printer secreteChar: $*.
	printer secreteMask: nil.
	
	actual := printer printValue: '12345'.
	
	actual should equal: '*****'
	
]
