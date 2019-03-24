Class {
	#name : #PtySimpleLabelPresenter,
	#superclass : #PtyPresenter,
	#category : #'Presenty-BasicPresenters'
}

{ #category : #accessing }
PtySimpleLabelPresenter class >> defaultView [

	^PtyTextLabel new
]

{ #category : #presentation }
PtySimpleLabelPresenter >> showViewItems [
	view labelName: model.
	view newContents: model.
]
