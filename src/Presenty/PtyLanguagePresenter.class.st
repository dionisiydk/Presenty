Class {
	#name : #PtyLanguagePresenter,
	#superclass : #PtyCompositePresenter,
	#category : #'Presenty-Presenters'
}

{ #category : #presentation }
PtyLanguagePresenter >> showIcon [

	model icon ifNil: [^self].
	model icon ifEmpty: [^self].
	
	self showItem: (PtyLabelPresenter imageNamed: model icon)
]

{ #category : #presentation }
PtyLanguagePresenter >> showViewItems [ 

	self showIcon.
	self showItem: (PtyLabelPresenter textNamed: model name).
]
