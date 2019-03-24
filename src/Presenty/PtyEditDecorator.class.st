Class {
	#name : #PtyEditDecorator,
	#superclass : #Object,
	#instVars : [
		'decoratedValue',
		'cursorPosition'
	],
	#category : #'Presenty-UI'
}

{ #category : #accessing }
PtyEditDecorator >> cursorPosition [
	^ cursorPosition
]

{ #category : #accessing }
PtyEditDecorator >> cursorPosition: aNumber [
	cursorPosition := aNumber 
]

{ #category : #evaluating }
PtyEditDecorator >> decoratedValue [
	^decoratedValue
]

{ #category : #evaluating }
PtyEditDecorator >> decoratedValue: aString [
	decoratedValue := aString
]

{ #category : #'initialize-release' }
PtyEditDecorator >> initialize [ 
	super initialize.
	decoratedValue := String new.
	cursorPosition := 0
]
