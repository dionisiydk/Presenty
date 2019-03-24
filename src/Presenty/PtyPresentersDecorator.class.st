Class {
	#name : #PtyPresentersDecorator,
	#superclass : #PtyCompositePresenter,
	#category : #'Presenty-BasicPresenters'
}

{ #category : #accessing }
PtyPresentersDecorator >> indexOfItem: aPresenter [ 

	^model indexOf: aPresenter 
]

{ #category : #'initialize-release' }
PtyPresentersDecorator >> initialize [ 
	super initialize.
	model := #()
]

{ #category : #presentation }
PtyPresentersDecorator >> showViewItems [ 

	model do: [:each | self showItem: each]
]
