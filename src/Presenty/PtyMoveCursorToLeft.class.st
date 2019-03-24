Class {
	#name : #PtyMoveCursorToLeft,
	#superclass : #PtyTextCursorMovement,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyMoveCursorToLeft >> applyTo: aTextEditorPresenter [

	| cursor |
	cursor := aTextEditorPresenter cursor.
	
	cursor shiftBy: -1
]
