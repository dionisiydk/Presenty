Class {
	#name : #PtyMaskedEditDecorator,
	#superclass : #PtyEditDecorator,
	#instVars : [
		'mask',
		'maskChar'
	],
	#category : #'Presenty-UI'
}

{ #category : #'instance creation' }
PtyMaskedEditDecorator class >> mask: aString [
	^self new mask: aString
]

{ #category : #evaluating }
PtyMaskedEditDecorator >> clearCharsBack: charsCount startingAt: position [

	| resetChars maskI |
	resetChars := 0.
	maskI := position.
	cursorPosition := position.
	[maskI > 1 and:[resetChars ~= charsCount]] whileTrue: [
		maskI := maskI - 1.
		(mask at: maskI) = maskChar ifTrue: [
			cursorPosition := maskI.
			decoratedValue at: cursorPosition put: maskChar.
			resetChars := resetChars + 1]].
		

		
]

{ #category : #evaluating }
PtyMaskedEditDecorator >> decorate: aString [ 
	decoratedValue := mask copy.
	self insertChars: aString at: 1.

]

{ #category : #'initialize-release' }
PtyMaskedEditDecorator >> initialize [ 
	super initialize.
	mask := ''.
	maskChar := $*
]

{ #category : #evaluating }
PtyMaskedEditDecorator >> insertChars: pastedChars at: anIndex [

	| charsStream |
	
	charsStream := pastedChars readStream.
	cursorPosition  := anIndex.
	[charsStream atEnd or:[cursorPosition > mask size]] whileFalse: [
		(mask at: cursorPosition) = maskChar ifTrue: [
			decoratedValue at: cursorPosition  put: charsStream next].
		cursorPosition  := cursorPosition  + 1].
]

{ #category : #accessing }
PtyMaskedEditDecorator >> mask [
	^ mask
]

{ #category : #accessing }
PtyMaskedEditDecorator >> mask: anObject [
	mask := anObject.
	decoratedValue := mask copy.
]

{ #category : #accessing }
PtyMaskedEditDecorator >> maskChar [
	^ maskChar
]

{ #category : #accessing }
PtyMaskedEditDecorator >> maskChar: anObject [
	maskChar := anObject
]

{ #category : #accessing }
PtyMaskedEditDecorator >> nativeValue [

^(String streamContents: [:s | 
		
		1 to: mask size do: [:i |
			(mask at: i)	= maskChar & ((decoratedValue at: i) ~= maskChar) ifTrue: [s nextPut: (decoratedValue at: i)]		
			]		
		]) 
]
