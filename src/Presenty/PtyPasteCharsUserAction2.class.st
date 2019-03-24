Class {
	#name : #PtyPasteCharsUserAction2,
	#superclass : #PtyTextEditorUserAction,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyPasteCharsUserAction2 >> executeWith: anObject [

	| string |
	string := anObject asString.
	
	presenter cursor pasteText: string

	
]
