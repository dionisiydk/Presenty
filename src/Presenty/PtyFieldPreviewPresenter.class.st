Class {
	#name : #PtyFieldPreviewPresenter,
	#superclass : #PtyCompositePresenter,
	#category : #'Presenty-Editor-Fields'
}

{ #category : #presentation }
PtyFieldPreviewPresenter >> showViewItems [

	self showItem: (PtyLabelPresenter textNamed: model desc displayName withStyle: #fieldName).
	self showItem: model valuePreviewPresenter  
]
