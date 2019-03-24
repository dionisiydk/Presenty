Class {
	#name : #PtyMoveCursorToStart,
	#superclass : #PtyTextCursorMovement,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyMoveCursorToStart >> applyTo: aTextEditorPresenter [

	| cursor |
	cursor := aTextEditorPresenter cursor.
	
	cursor location: 0
]
