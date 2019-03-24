Class {
	#name : #PtyMaskedValuePrinter,
	#superclass : #PtyValuePrinter,
	#instVars : [
		'mask',
		'maskChar'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #'instance creation' }
PtyMaskedValuePrinter class >> mask: aString [

	^self new 
		mask: aString 
]

{ #category : #accessing }
PtyMaskedValuePrinter >> editDecorator [ 
	
	^PtyMaskedEditDecorator new 
		mask: mask;
		maskChar: maskChar 
]

{ #category : #'initialize-release' }
PtyMaskedValuePrinter >> initialize [ 
	super initialize.
	mask := ''.
	maskChar := $*
]

{ #category : #accessing }
PtyMaskedValuePrinter >> mask [
	^ mask
]

{ #category : #accessing }
PtyMaskedValuePrinter >> mask: anObject [
	mask := anObject
]

{ #category : #accessing }
PtyMaskedValuePrinter >> maskChar [
	^ maskChar
]

{ #category : #accessing }
PtyMaskedValuePrinter >> maskChar: anObject [
	maskChar := anObject
]

{ #category : #printing }
PtyMaskedValuePrinter >> printValue: aString [ 

	| charsStream decoratedValue index |

	decoratedValue := mask copy.
	aString ifNil: [^decoratedValue].
	
	charsStream := aString readStream.
	
	index  := 1.
	[charsStream atEnd or:[index > mask size]] whileFalse: [
		(mask at: index) = maskChar ifTrue: [
			decoratedValue at: index  put: charsStream next].
		index  := index  + 1].
	
	^decoratedValue 
]
