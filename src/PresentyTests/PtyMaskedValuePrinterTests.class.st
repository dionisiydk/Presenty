Class {
	#name : #PtyMaskedValuePrinterTests,
	#superclass : #PtyValuePrinterTestCase,
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyMaskedValuePrinterTests >> printerClass [
	^PtyMaskedValuePrinter 
]

{ #category : #tests }
PtyMaskedValuePrinterTests >> testHasEmptyMaskByDefault [

	printer mask should be isEmpty 
]

{ #category : #tests }
PtyMaskedValuePrinterTests >> testHasMaskCharByDefault [

	printer maskChar should beInstanceOf: Character 
]

{ #category : #tests }
PtyMaskedValuePrinterTests >> testHasMaskedEditDecorator [
	| actual |

	printer mask: #mask.
	printer maskChar: #maskChar.
	
	actual := printer editDecorator.
	
	actual should beInstanceOf: PtyMaskedEditDecorator.
	actual mask should be: #mask.
	actual maskChar should be: #maskChar
]

{ #category : #tests }
PtyMaskedValuePrinterTests >> testPrintingNilValue [
	| actual |

	printer mask: '123***987***'.
	
	actual := printer printValue: nil.
	
	actual should equal: '123***987***'
]

{ #category : #tests }
PtyMaskedValuePrinterTests >> testPrintingString [
	| actual |

	printer mask: '123***987***'.
	
	actual := printer printValue: 'chars'.
	
	actual should equal: '123cha987rs*'
]

{ #category : #tests }
PtyMaskedValuePrinterTests >> testPrintingStringWhenEmptyMask [
	
	| actual |
	printer mask: ''.
	
	actual := printer printValue: 'chars123456'.
	
	actual should equal: ''
]

{ #category : #tests }
PtyMaskedValuePrinterTests >> testPrintingStringWhichLongerThenMask [
	
	| actual |
	printer mask: '123***987***'.
	
	actual := printer printValue: 'chars123456'.
	
	actual should equal: '123cha987rs1'
]
