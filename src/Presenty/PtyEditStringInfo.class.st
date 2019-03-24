Class {
	#name : #PtyEditStringInfo,
	#superclass : #Object,
	#instVars : [
		'source',
		'editStart',
		'pasted',
		'deleted'
	],
	#category : #'Presenty-UI'
}

{ #category : #accessing }
PtyEditStringInfo class >> on: aString [
	^self new source: aString
]

{ #category : #evaluation }
PtyEditStringInfo >> computeFor: editedSourceString [

	| startIndex endOldIndex endNewIndex |
	
	startIndex := 1.
	[startIndex <= source size & (startIndex <= editedSourceString size) and: [(source at: startIndex) = (editedSourceString at: startIndex)]]
		whileTrue: [startIndex := startIndex + 1].

	endOldIndex := source size.
	endNewIndex := editedSourceString size.
	[endOldIndex >= startIndex & (endNewIndex >= startIndex ) 
			and: [(source at: endOldIndex) = (editedSourceString at: endNewIndex)]]
		 whileTrue: [endOldIndex := endOldIndex - 1. endNewIndex := endNewIndex - 1].
	
	"(startIndex < source size and: [startIndex > endOldIndex & ((source at: startIndex) = (source at: endNewIndex))]) ifTrue: [
		startIndex := startIndex - 1.
		endOldIndex := endOldIndex - 1.
		endNewIndex := endNewIndex - 1.
		]."
	pasted := editedSourceString copyFrom: startIndex to: endNewIndex.
	deleted := source copyFrom: startIndex to: endOldIndex.
	editStart := startIndex
]

{ #category : #evaluation }
PtyEditStringInfo >> computeFor: editedSourceString newPosition: newPosition [

	| startIndex endOldIndex endNewIndex |
	
	startIndex := 1.
	[startIndex <= source size & (startIndex <= editedSourceString size) and: [(source at: startIndex) = (editedSourceString at: startIndex)]]
		whileTrue: [startIndex := startIndex + 1].

	endOldIndex := source size.
	endNewIndex := editedSourceString size.
	[endOldIndex >= startIndex & (endNewIndex >= startIndex ) 
			and: [(source at: endOldIndex) = (editedSourceString at: endNewIndex)]]
		 whileTrue: [endOldIndex := endOldIndex - 1. endNewIndex := endNewIndex - 1].
	

	pasted := editedSourceString copyFrom: startIndex to: endNewIndex.
	deleted := source copyFrom: startIndex to: endOldIndex.
	editStart := 	newPosition - pasted size
]

{ #category : #accessing }
PtyEditStringInfo >> deleteEnd [
	^ editStart + deleted size
]

{ #category : #accessing }
PtyEditStringInfo >> deleted [
	^ deleted
]

{ #category : #accessing }
PtyEditStringInfo >> deleted: anObject [
	deleted := anObject
]

{ #category : #accessing }
PtyEditStringInfo >> editStart [
	^ editStart
]

{ #category : #accessing }
PtyEditStringInfo >> editStart: anObject [
	editStart := anObject
]

{ #category : #testing }
PtyEditStringInfo >> hasDeleted [
	^deleted notEmpty 
]

{ #category : #testing }
PtyEditStringInfo >> hasPasted [
	^pasted notEmpty 
]

{ #category : #accessing }
PtyEditStringInfo >> pasteEnd [
	^ editStart + pasted size
]

{ #category : #accessing }
PtyEditStringInfo >> pasted [
	^ pasted
]

{ #category : #accessing }
PtyEditStringInfo >> pasted: anObject [
	pasted := anObject
]

{ #category : #accessing }
PtyEditStringInfo >> source [
	^ source
]

{ #category : #accessing }
PtyEditStringInfo >> source: anObject [
	source := anObject
]
