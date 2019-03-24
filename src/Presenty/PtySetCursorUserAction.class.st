Class {
	#name : #PtySetCursorUserAction,
	#superclass : #PtyTextEditorUserAction,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtySetCursorUserAction >> executeWith: aPoint [

	presenter cursor moveToPosition: aPoint.
	presenter view takeKeyboardFocus 
]
