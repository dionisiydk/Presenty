Class {
	#name : #PtyDecimalValueEditDecoratorTests,
	#superclass : #PtyEditDecoratorTestCase,
	#category : #'PresentyTests-UI'
}

{ #category : #running }
PtyDecimalValueEditDecoratorTests >> decoratorClass [ 
	^PtyDecimalValueEditDecorator 
]

{ #category : #tests }
PtyDecimalValueEditDecoratorTests >> testInsertingDecimalPartWhenItTooBig [
	
	decorator decimalDigitsCount: 3.
	decorator decoratedValue: '1.23'.
	decorator insertChars: '456' at: 3.
	
	decorator decoratedValue should equal: '1.423'.
	decorator cursorPosition should equal: 4
]

{ #category : #tests }
PtyDecimalValueEditDecoratorTests >> testInsertingDotAtStartPosition [
	
	decorator decoratedValue: '123'.
	decorator insertChars: '.' at: 1.
	
	decorator decoratedValue should equal: '123'
]

{ #category : #tests }
PtyDecimalValueEditDecoratorTests >> testInsertingDotWhenItAlreadyExist [
	
	decorator decoratedValue: '123.45'.
	decorator insertChars: '.' at: 1.
	
	decorator decoratedValue should equal: '123.45'
]

{ #category : #tests }
PtyDecimalValueEditDecoratorTests >> testInsertingDotWhenItNotYetExist [
	
	decorator decoratedValue: '123'.
	decorator insertChars: '.' at: 2.
	
	decorator decoratedValue should equal: '1.23'.
	decorator cursorPosition should equal: 3
]

{ #category : #tests }
PtyDecimalValueEditDecoratorTests >> testInsertingIntegerPartWhenValueBecomeTooBig [
	
	decorator maxValue: 1000.
	decorator decoratedValue: '12'.
	decorator insertChars: '456' at: 3.
	
	decorator decoratedValue should equal: '124'.
	decorator cursorPosition should equal: 4
]
