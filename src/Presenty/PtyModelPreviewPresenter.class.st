Class {
	#name : #PtyModelPreviewPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'aspects'
	],
	#category : #'Presenty-Presenters'
}

{ #category : #'instance creation' }
PtyModelPreviewPresenter class >> on: aModel aspects: anArray [

	^(self on: aModel)
		aspects: anArray 
]

{ #category : #accessing }
PtyModelPreviewPresenter >> aspects [
	^ aspects
]

{ #category : #accessing }
PtyModelPreviewPresenter >> aspects: anObject [
	aspects := anObject
]

{ #category : #accessing }
PtyModelPreviewPresenter >> defaultPrototypeGroupName [ 
	^'PreviewOf', model class name
]

{ #category : #presentation }
PtyModelPreviewPresenter >> showViewItems [ 

	aspects do: [:each | 
		self showItem: (PtyAspectPreviewPresenter on: model aspect: each)].	
	
]
