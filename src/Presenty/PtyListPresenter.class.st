Class {
	#name : #PtyListPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'itemPresenterFactory'
	],
	#category : #'Presenty-Presenters'
}

{ #category : #'instance creation' }
PtyListPresenter class >> on: anObject itemsSpec: aClass [

	^(self on: anObject)
		itemsSpec: aClass 
]

{ #category : #presentation }
PtyListPresenter >> showViewItems [ 
	
	model do: [:each | 
		
		self showItem: (itemPresenterFactory presenterOn: each for: self context task)
		
		]
]
