Class {
	#name : #PtyPresenterPreviewFactory,
	#superclass : #PtyPresenterFactory,
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'presenters creation' }
PtyPresenterPreviewFactory >> presenterOn: aModelObject for: aTask [

	^aModelObject preferredPreviewPresenter 
]
