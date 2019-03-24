Class {
	#name : #PtySimpleImagePresenter,
	#superclass : #PtyPresenter,
	#category : #'Presenty-BasicPresenters'
}

{ #category : #accessing }
PtySimpleImagePresenter class >> defaultView [

	^PtyImageLabel new
]

{ #category : #presentation }
PtySimpleImagePresenter >> showViewItems [

	view image: model
]
