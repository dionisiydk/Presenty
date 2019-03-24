Class {
	#name : #PtyPasteCharsUserAction,
	#superclass : #PtyUserAction,
	#instVars : [
		'editor'
	],
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #accessing }
PtyPasteCharsUserAction >> editor: aTextEditor [
	editor := aTextEditor
]

{ #category : #execution }
PtyPasteCharsUserAction >> executeWith: aString [ 
	editor appendChar: aString first
]
