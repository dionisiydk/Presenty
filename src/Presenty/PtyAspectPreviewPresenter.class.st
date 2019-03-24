Class {
	#name : #PtyAspectPreviewPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'aspect'
	],
	#category : #'Presenty-Presenters'
}

{ #category : #'instance creation' }
PtyAspectPreviewPresenter class >> on: aModel aspect: aSymbol [

	^(self on: aModel)
		aspect: aSymbol 
]

{ #category : #accessing }
PtyAspectPreviewPresenter >> aspect [
	^ aspect
]

{ #category : #accessing }
PtyAspectPreviewPresenter >> aspect: anObject [
	aspect := anObject
]

{ #category : #presentation }
PtyAspectPreviewPresenter >> showViewItems [ 

	self showItem: (PtyLabelPresenter textNamed: aspect withStyle: #aspectName).
	self showItem: (PtySimpleLabelPresenter on: (model perform: aspect) asString withStyle: #aspectValue)
]
