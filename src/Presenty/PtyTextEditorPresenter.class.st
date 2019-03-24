Class {
	#name : #PtyTextEditorPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'cursor',
		'selection',
		'editor'
	],
	#category : #'Presenty-TextEditor'
}

{ #category : #accessing }
PtyTextEditorPresenter >> cursor [
	^ cursor
]

{ #category : #accessing }
PtyTextEditorPresenter >> cursor: anObject [
	cursor := anObject
]

{ #category : #accessing }
PtyTextEditorPresenter >> editor [
	^ editor
]

{ #category : #accessing }
PtyTextEditorPresenter >> editor: anObject [
	editor := anObject
]

{ #category : #'initialize-release' }
PtyTextEditorPresenter >> initialize [ 
	super initialize.
	model := ''.
	
	PtyTextEditorUserAction allSubclasses do: [:eachClass |  
		self addUserAction: eachClass new]
]

{ #category : #accessing }
PtyTextEditorPresenter >> selection [
	^ selection
]

{ #category : #accessing }
PtyTextEditorPresenter >> selection: anObject [
	selection := anObject
]

{ #category : #presentation }
PtyTextEditorPresenter >> showViewItems [ 

	| presenter |
	
	presenter := PtyStringPresenter on: model.	
	self showItem: presenter.
	
	cursor := PtyTextCursor on: presenter.
	self showItem: (PtyTextCursorPresenter on: cursor)
]
