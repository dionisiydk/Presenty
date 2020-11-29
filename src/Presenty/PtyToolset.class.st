Class {
	#name : #PtyToolset,
	#superclass : #PtyTool,
	#instVars : [
		'contents'
	],
	#category : #'Presenty-Tools'
}

{ #category : #controlling }
PtyToolset >> attachToPanel [
	contents do: [:each | each attachToPanel ]
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
