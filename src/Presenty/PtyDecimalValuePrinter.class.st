Class {
	#name : #PtyDecimalValuePrinter,
	#superclass : #PtyValuePrinter,
	#instVars : [
		'decimalDigitsCount'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #accessing }
PtyDecimalValuePrinter >> decimalDigitsCount [
	^ decimalDigitsCount
]

{ #category : #accessing }
PtyDecimalValuePrinter >> decimalDigitsCount: anObject [
	decimalDigitsCount := anObject
]

{ #category : #accessing }
PtyDecimalValuePrinter >> editDecorator [ 
	^PtyNoneEditDecorator new 
]

{ #category : #'initialize-release' }
PtyDecimalValuePrinter >> initialize [ 
	super initialize.
	
	decimalDigitsCount := 0
]

{ #category : #printing }
PtyDecimalValuePrinter >> printValue: aNumber [
	aNumber ifNil: [^''].

	^aNumber printShowingDecimalPlaces: decimalDigitsCount 
]
