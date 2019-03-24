Class {
	#name : #PtyDecimalValueEditDecorator,
	#superclass : #PtyNoneEditDecorator,
	#instVars : [
		'maxValue',
		'decimalDigitsCount'
	],
	#category : #'Presenty-UI'
}

{ #category : #'instance creation' }
PtyDecimalValueEditDecorator class >> maxValue: aNumber decimalDigitsCount: decimalLength [

	^self new 
		maxValue: aNumber;
		decimalDigitsCount: decimalLength 
]

{ #category : #accessing }
PtyDecimalValueEditDecorator >> decimalDigitsCount [
	^ decimalDigitsCount
]

{ #category : #accessing }
PtyDecimalValueEditDecorator >> decimalDigitsCount: anObject [
	decimalDigitsCount := anObject
]

{ #category : #evaluating }
PtyDecimalValueEditDecorator >> decorate: aString [ 

	decoratedValue := aString.
	decoratedValue ifEmpty: [^self].
	decoratedValue first = $. ifTrue: [decoratedValue := '0', decoratedValue ].
	[self isDecoratedValueValid] whileFalse: [decoratedValue := decoratedValue allButLast]
]

{ #category : #'initialize-release' }
PtyDecimalValueEditDecorator >> initialize [ 
	super initialize.
	
	maxValue := 1000000.
	decimalDigitsCount := 2
]

{ #category : #evaluating }
PtyDecimalValueEditDecorator >> insertChars: aString at: position [
	| firstPart lastPart sourceString |

	(aString includes: $.) & (decoratedValue includes: $.)
		ifTrue: [^self]. 
		
	sourceString := aString.	
	
	firstPart := decoratedValue isEmpty ifTrue: [''] ifFalse: [decoratedValue copyFrom: 1 to: position - 1].
	lastPart := decoratedValue size + 1 = position ifTrue: [''] ifFalse: [decoratedValue copyFrom: position to: decoratedValue size].
	
	[decoratedValue := firstPart, sourceString, lastPart.
	decoratedValue first = $. ifTrue: [^decoratedValue := firstPart , lastPart].
	self isDecoratedValueValid] whileFalse: [sourceString := sourceString allButLast].
	
	cursorPosition := position + sourceString size
]

{ #category : #testing }
PtyDecimalValueEditDecorator >> isDecoratedValueValid [

	| number pointIndex |

	number := self parseNumberFrom: decoratedValue. 
	
	pointIndex := decoratedValue indexOf: $..
	
	^number <= maxValue and: [pointIndex = 0 or: [decoratedValue size - pointIndex <= decimalDigitsCount]]
	
]

{ #category : #accessing }
PtyDecimalValueEditDecorator >> maxValue [
	^ maxValue
]

{ #category : #accessing }
PtyDecimalValueEditDecorator >> maxValue: anObject [
	maxValue := anObject
]

{ #category : #evaluating }
PtyDecimalValueEditDecorator >> parseNumberFrom: sourceString [	
	^sourceString last = $. 
		ifTrue: [sourceString allButLast asNumber]
		ifFalse: [sourceString asNumber].

]
