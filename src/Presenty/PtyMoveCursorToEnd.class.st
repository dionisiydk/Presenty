Class {
	#name : #PtyMoveCursorToEnd,
	#superclass : #PtyTextCursorMovement,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyMoveCursorToEnd >> applyTo: aTextEditorPresenter [

	| cursor |
	cursor := aTextEditorPresenter cursor.
	
	cursor location: cursor currentPiece model size
]
