Class {
	#name : #PtyTextMorphDecorationValueTests,
	#superclass : #TestCase,
	#instVars : [
		'morph',
		'decorator',
		'valueSpec',
		'textConverter'
	],
	#category : #'PresentyTests-UI'
}

{ #category : #tests }
PtyTextMorphDecorationValueTests >> newValidValueSpec [
	decorator nativeValue useArbitrarily; willReturn: #newStringValue.		
	(textConverter canConvertString: #newStringValue) willReturn: true.
	(textConverter readValueFrom: #newStringValue) willReturn: #newValue.
	 (valueSpec validate: #newValue) willReturn: SpecOfValidationResult success
]

{ #category : #running }
PtyTextMorphDecorationValueTests >> setUp [
	super setUp.
	
	morph := PtyTextInputMorph new.
	decorator := Mock new.
	valueSpec := Mock new.
	textConverter := Mock new.
	morph 
		editDecorator: decorator;
		valueSpec: valueSpec;
		textConverter: textConverter
]

{ #category : #tests }
PtyTextMorphDecorationValueTests >> testWhenItHasSameSizeAsOldValue [
	
	[
		[morph decorate: '1234567' at: 6 oldValue: '12asd67' at: 3]
				should strictly satisfy: 
		[decorator clearCharsBack: 3 startingAt: 6.		
		decorator insertChars: '345' at: 3.
		self newValidValueSpec]
	] runWithMocks 
]

{ #category : #tests }
PtyTextMorphDecorationValueTests >> testWhenValueWithNewCharsAndNotConvertable [
	
	[
		[morph decorate: '1234567' at: 6 oldValue: '12367' at: 4]
			should lenient satisfy: 
		[decorator nativeValue willReturn: #newStringValue; useArbitrarily.
		decorator insertChars: '45' at: 4.
		(textConverter canConvertString: #newStringValue) willReturn: false.
		decorator decoratedValue: '12367'.
		decorator cursorPosition: 4]
	] runWithMocks 
]

{ #category : #tests }
PtyTextMorphDecorationValueTests >> testWhenValueWithNewCharsAndNotValid [
	
	[
		[morph decorate: '1234567' at: 6 oldValue: '12367' at: 4]
			should lenient satisfy: 
		[decorator nativeValue willReturn: #newStringValue; useArbitrarily.
		decorator insertChars: '45' at: 4.
		(textConverter canConvertString: #newStringValue) willReturn: true.
		(textConverter readValueFrom: #newStringValue) willReturn: #newValue.
		(valueSpec validate: #newValue) willReturn: SpecOfValidationFailure new.
		decorator decoratedValue: '12367'.
		decorator cursorPosition: 4]
	] runWithMocks 
]

{ #category : #tests }
PtyTextMorphDecorationValueTests >> testWhenValueWithNewCharsAndValid [
	
	[
		[morph decorate: '1234567' at: 6 oldValue: '12367' at: 4]
			should lenient satisfy: 
		[decorator nativeValue willReturn: #newStringValue; useArbitrarily.
		decorator insertChars: '45' at: 4.
		self newValidValueSpec]
	] runWithMocks 
]

{ #category : #tests }
PtyTextMorphDecorationValueTests >> testWhenValueWithoutManyChars [
	
	[
		[morph decorate: '12367' at: 4 oldValue: '1234567' at: 6]
			should lenient satisfy: 
		[decorator clearCharsBack: 2 startingAt:  6	]
	] runWithMocks 
]

{ #category : #tests }
PtyTextMorphDecorationValueTests >> testWhenValueWithoutSingleCharButPositionUnchanged [
	
	[
		[morph decorate: '123467' at: 5 oldValue: '1234567' at: 5]
			should lenient satisfy: 
		[decorator clearCharsBack: 1 startingAt:  6	]
	] runWithMocks 
]
