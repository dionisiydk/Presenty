Class {
	#name : #PtyMoveCursorToNextLeftWord,
	#superclass : #PtyTextCursorMovement,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyMoveCursorToNextLeftWord >> applyTo: aTextEditorPresenter [

	| cursor position |
	cursor := aTextEditorPresenter cursor.
	position := cursor nextLeftWordPosition.
	
	cursor location: position
]
