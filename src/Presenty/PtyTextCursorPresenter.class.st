Class {
	#name : #PtyTextCursorPresenter,
	#superclass : #PtyCompositePresenter,
	#category : #'Presenty-TextEditor'
}

{ #category : #presentation }
PtyTextCursorPresenter >> hookupModel [

	model on: PtyValueChanged send: #showViewItems to: self	
]

{ #category : #presentation }
PtyTextCursorPresenter >> showViewItems [ 

	view position: model computeViewPosition.
	view height: model currentPiece view height.
	view comeToFront.
	
]

{ #category : #presentation }
PtyTextCursorPresenter >> unhookModel [

	model unsubscribe: self	
]
