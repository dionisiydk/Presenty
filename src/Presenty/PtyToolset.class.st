Class {
	#name : #PtyToolset,
	#superclass : #PtyTool,
	#instVars : [
		'contents'
	],
	#category : #'Presenty-Tools'
}

{ #category : #controlling }
PtyToolset >> activateOnPanel [
	contents do: [:each | each activateOnPanel ]
]

{ #category : #accessing }
PtyToolset >> contents [
	^ contents
]

{ #category : #accessing }
PtyToolset >> contents: anObject [
	contents := anObject
]

{ #category : #controlling }
PtyToolset >> detachFromPanel [
	contents do: [:each | each detachFromPanel ]
]
