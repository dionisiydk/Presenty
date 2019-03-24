Class {
	#name : #PtyMoveCursorToNextRightWord,
	#superclass : #PtyTextCursorMovement,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyMoveCursorToNextRightWord >> applyTo: aTextEditorPresenter [

	| cursor position |
	cursor := aTextEditorPresenter cursor.
	position := cursor nextRightWordPosition.
	
	cursor location: position
]
