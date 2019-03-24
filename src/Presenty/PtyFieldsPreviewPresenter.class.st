Class {
	#name : #PtyFieldsPreviewPresenter,
	#superclass : #PtyCompositePresenter,
	#category : #'Presenty-Editor-Fields'
}

{ #category : #presentation }
PtyFieldsPreviewPresenter >> showViewItems [ 

	model do: [:each | 

		self showItem: (PtyFieldPreviewPresenter on: each).
		
		].
]
