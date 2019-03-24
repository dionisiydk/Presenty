Class {
	#name : #PtyTextModel,
	#superclass : #Object,
	#instVars : [
		'sourceString',
		'pieces'
	],
	#category : #'Presenty-TextEditor'
}

{ #category : #accessing }
PtyTextModel >> pieces [
	^ pieces
]

{ #category : #accessing }
PtyTextModel >> pieces: anObject [
	pieces := anObject
]

{ #category : #accessing }
PtyTextModel >> sourceString [
	^ sourceString
]

{ #category : #accessing }
PtyTextModel >> sourceString: anObject [
	sourceString := anObject
]
