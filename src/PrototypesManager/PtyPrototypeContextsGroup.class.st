Class {
	#name : #PtyPrototypeContextsGroup,
	#superclass : #Object,
	#instVars : [
		'parent',
		'contents'
	],
	#category : #PrototypesManager
}

{ #category : #accessing }
PtyPrototypeContextsGroup >> contents [
	^ contents
]

{ #category : #accessing }
PtyPrototypeContextsGroup >> contents: anObject [
	contents := anObject
]

{ #category : #accessing }
PtyPrototypeContextsGroup >> parent [
	^ parent
]

{ #category : #accessing }
PtyPrototypeContextsGroup >> parent: anObject [
	parent := anObject
]
