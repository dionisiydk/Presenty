Class {
	#name : #PtyNoneEditDecorator,
	#superclass : #PtyEditDecorator,
	#category : #'Presenty-UI'
}

{ #category : #evaluating }
PtyNoneEditDecorator >> clearCharsBack: charsCount startingAt: position [
	| firstPart lastPart |

	firstPart := position - charsCount < 1 ifTrue: [''] ifFalse: [decoratedValue copyFrom: 1 to: position - charsCount - 1].
	lastPart := decoratedValue size + 1 = position ifTrue: [''] ifFalse: [decoratedValue copyFrom: position to: decoratedValue size].
	decoratedValue := firstPart, lastPart.
	
	cursorPosition := position - charsCount max: 1
]

{ #category : #evaluating }
PtyNoneEditDecorator >> decorate: aString [ 
	decoratedValue := aString
]

{ #category : #evaluating }
PtyNoneEditDecorator >> insertChars: aString at: position [
	| firstPart lastPart |

	firstPart := decoratedValue isEmpty ifTrue: [''] ifFalse: [decoratedValue copyFrom: 1 to: position - 1].
	lastPart := decoratedValue size + 1 = position ifTrue: [''] ifFalse: [decoratedValue copyFrom: position to: decoratedValue size].
	decoratedValue := firstPart, aString, lastPart.
	
	cursorPosition := position + aString size
]

{ #category : #accessing }
PtyNoneEditDecorator >> nativeValue [
	^decoratedValue
]
