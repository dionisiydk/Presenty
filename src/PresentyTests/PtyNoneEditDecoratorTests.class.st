Class {
	#name : #PtyNoneEditDecoratorTests,
	#superclass : #PtyEditDecoratorTestCase,
	#category : #'PresentyTests-UI'
}

{ #category : #accessing }
PtyNoneEditDecoratorTests >> decoratorClass [
	^PtyNoneEditDecorator
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testClearCharsStartingAtFirstPosition [
	
	decorator decoratedValue: 'some'.
	decorator clearCharsBack: 10 startingAt: 1.
	
	decorator decoratedValue should equal: 'some'.
	decorator cursorPosition should equal: 1
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testClearCharsStartingAtLastPosition [
	
	decorator decoratedValue: 'some'.
	decorator clearCharsBack: 2 startingAt: 'some' size + 1.
	
	decorator decoratedValue should equal: 'so'.
	decorator cursorPosition should equal: 'so' size + 1
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testClearCharsStartingAtMiddlePosition [
	
	decorator decoratedValue: 'some'.
	decorator clearCharsBack: 2 startingAt: 4.
	
	decorator decoratedValue should equal: 'se'.
	decorator cursorPosition should equal: 2
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testClearCharsWhenEmptyCurrentValue [
	
	decorator decoratedValue: ''.
	decorator clearCharsBack: 10 startingAt: 1.
	
	decorator decoratedValue should equal: ''.
	decorator cursorPosition should equal: 1
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testClearTooManyChars [
	
	decorator decoratedValue: 'some'.
	decorator clearCharsBack: 10 startingAt: 4.
	
	decorator decoratedValue should equal: 'e'.
	decorator cursorPosition should equal: 1
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testDecorationValue [
	
	decorator decorate: 'some'.
	
	decorator decoratedValue should equal: 'some'
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testGettingNativeValue [
	
	decorator decoratedValue: 'some'.
	
	decorator nativeValue should equal: 'some'
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testInsertingCharsAtFirstPosition [
	
	decorator decoratedValue: 'some'.
	decorator insertChars: 'chars' at: 1.
	
	decorator decoratedValue should equal: 'charssome'
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testInsertingCharsAtLastPosition [
	
	decorator decoratedValue: 'some'.
	decorator insertChars: 'chars' at: 'some' size + 1.
	
	decorator decoratedValue should equal: 'somechars'.
	decorator cursorPosition should equal: 'somechars' size + 1
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testInsertingCharsAtMiddlePosition [
	
	decorator decoratedValue: 'some'.
	decorator insertChars: 'chars' at: 2.
	
	decorator decoratedValue should equal: 'scharsome'
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testInsertingCharsShouldSetCursorPosition [
	
	decorator decoratedValue: 'some'.
	decorator insertChars: 'chars' at: 2.
	
	decorator cursorPosition should equal: 'chars' size + 2
]

{ #category : #tests }
PtyNoneEditDecoratorTests >> testInsertingCharsWhenEmptyCurrentValue [
	
	decorator insertChars: 'some' at: 1.
	
	decorator decoratedValue should equal: 'some'
]
