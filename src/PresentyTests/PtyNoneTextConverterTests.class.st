Class {
	#name : #PtyNoneTextConverterTests,
	#superclass : #PtyTextConverterTestCase,
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyNoneTextConverterTests >> converterClass [

	^PtyNoneTextConverter
]

{ #category : #tests }
PtyNoneTextConverterTests >> testCanConvertAnyString [

	| actual |
	actual := converter canConvertString: Any.
	
	actual should be: true
	
	
]

{ #category : #tests }
PtyNoneTextConverterTests >> testReadingValueFromString [

	| actual |
	actual := converter readValueFrom: #stringValue.
	
	actual should be: #stringValue
	
	
]
