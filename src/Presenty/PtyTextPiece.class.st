Class {
	#name : #PtyTextPiece,
	#superclass : #Object,
	#instVars : [
		'position',
		'value'
	],
	#category : #'Presenty-TextEditor'
}

{ #category : #accessing }
PtyTextPiece >> position [
	^ position
]

{ #category : #accessing }
PtyTextPiece >> position: anObject [
	position := anObject
]

{ #category : #accessing }
PtyTextPiece >> value [
	^value
]

{ #category : #accessing }
PtyTextPiece >> value: anObject [
	value := anObject
]
