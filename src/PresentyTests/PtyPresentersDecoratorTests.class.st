Class {
	#name : #PtyPresentersDecoratorTests,
	#superclass : #PtyPresenterTestCase,
	#category : #'PresentyTests-BasicPresenters'
}

{ #category : #running }
PtyPresentersDecoratorTests >> createPresenter [

	^PtyPresentersDecorator new
]

{ #category : #tests }
PtyPresentersDecoratorTests >> testHasEmptyArrayModelByDefault [

	presenter model should be isEmpty
]

{ #category : #tests }
PtyPresentersDecoratorTests >> testShowingViewItems [ 

	[:item1 :item2 |
		presenter model: {item1. item2}.
		
		[presenter showViewItems]
			should strictly satisfy: 
		[item1 parent: presenter.
		guide preparePresenter: item1.
		item1 view willReturn: #item1View.
		presenterView add: #item1View.
		item2 parent: presenter.
		guide preparePresenter: item2.
		item2 view willReturn: #item2View.
		presenterView add: #item2View]
	] runWithMocks 
]
