Class {
	#name : #PtyLabelPresenter,
	#superclass : #PtyPresenter,
	#category : #'Presenty-BasicPresenters'
}

{ #category : #'instance creation' }
PtyLabelPresenter class >> imageNamed: labelName [

	^PtyImageLabelPresenter on: labelName 
]

{ #category : #'instance creation' }
PtyLabelPresenter class >> imageNamed: labelName withStyle: styleName [

	^PtyImageLabelPresenter on: labelName withStyle: styleName 
]

{ #category : #'instance creation' }
PtyLabelPresenter class >> textNamed: labelName [

	^PtyTextLabelPresenter on: labelName
]

{ #category : #'instance creation' }
PtyLabelPresenter class >> textNamed: labelName withStyle: styleName [

	^PtyTextLabelPresenter on: labelName withStyle: styleName 
]

{ #category : #presentation }
PtyLabelPresenter >> showViewItems [
	view labelName: model.
	guide translateContentOf: view.
]
