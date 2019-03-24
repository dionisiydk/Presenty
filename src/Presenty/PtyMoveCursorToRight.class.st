Class {
	#name : #PtyMoveCursorToRight,
	#superclass : #PtyTextCursorMovement,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyMoveCursorToRight >> applyTo: aTextEditorPresenter [

	| cursor |
	cursor := aTextEditorPresenter cursor.
	
	cursor shiftBy: 1
]
