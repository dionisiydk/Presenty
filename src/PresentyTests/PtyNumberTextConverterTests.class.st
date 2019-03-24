Class {
	#name : #PtyNumberTextConverterTests,
	#superclass : #PtyTextConverterTestCase,
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #running }
PtyNumberTextConverterTests >> converterClass [
	^PtyNumberTextConverter 
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertEmptyString [

	| actual |
	actual := converter canConvertString: ''.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithBigFloat [

	| actual |
	actual := converter canConvertString: '123123123.456456456456456'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithCommaSeparatorAtTheEnd [

	| actual |
	actual := converter canConvertString: '123,'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithFirstZero [

	| actual |
	actual := converter canConvertString: '0123'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithFirstZeroAndNextPoint [

	| actual |
	actual := converter canConvertString: '0.123'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithFloatWithCommaSeparator [

	| actual |
	actual := converter canConvertString: '123,45'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithFloatWithPointSeparator [

	| actual |
	actual := converter canConvertString: '123.45'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithInteger [

	| actual |
	actual := converter canConvertString: '123'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithPointSeparatorAtTheEnd [

	| actual |
	actual := converter canConvertString: '123.'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCanConvertStringWithTwoLeadingZero [

	| actual |
	actual := converter canConvertString: '00123.'.
	
	actual should be: true
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCantConvertStringWithChars [

	| actual |
	actual := converter canConvertString: 'asd'.
	
	actual should be: false
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCantConvertStringWithCharsAndDigits [

	| actual |
	actual := converter canConvertString: '12sa3.45'.
	
	actual should be: false
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCantConvertStringWithOnlySeparator [

	| actual |
	actual := converter canConvertString: '.'.
	
	actual should be: false
]

{ #category : #tests }
PtyNumberTextConverterTests >> testCantConvertStringWithSecondSeparatorAtTheEnd [

	| actual |
	actual := converter canConvertString: '123.45.'.
	
	actual should be: false
]

{ #category : #tests }
PtyNumberTextConverterTests >> testReadingFloatFromStringWithCommaSeparator [

	| actual |
	actual := converter readValueFrom: '123,45'.
	
	actual should equal: 123.45
]

{ #category : #tests }
PtyNumberTextConverterTests >> testReadingFloatFromStringWithFirstPointSeparator [

	| actual |
	actual := converter readValueFrom: '.45'.
	
	actual should equal: 0.45
]

{ #category : #tests }
PtyNumberTextConverterTests >> testReadingFloatFromStringWithPointSeparator [

	| actual |
	actual := converter readValueFrom: '123.45'.
	
	actual should equal: 123.45
]

{ #category : #tests }
PtyNumberTextConverterTests >> testReadingFloatFromStringWithPointSeparatorButWithoutDecimalDigits [

	| actual |
	actual := converter readValueFrom: '123.'.
	
	actual should equal: 123
]

{ #category : #tests }
PtyNumberTextConverterTests >> testReadingIntegerFromString [

	| actual |
	actual := converter readValueFrom: '123'.
	
	actual should equal: 123
]

{ #category : #tests }
PtyNumberTextConverterTests >> testReadingNumberFromEmptyString [

	| actual |
	actual := converter readValueFrom: ''.
	
	actual should equal: nil
]
