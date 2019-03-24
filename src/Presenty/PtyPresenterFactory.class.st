Class {
	#name : #PtyPresenterFactory,
	#superclass : #Object,
	#category : #'Presenty-ShowListTasks'
}

{ #category : #convertion }
PtyPresenterFactory >> convertTo: aPresenterFactory [

	^aPresenterFactory 
]

{ #category : #'presenters creation' }
PtyPresenterFactory >> presenterOn: aModelObject for: aTask [

	self subclassResponsibility 
]
