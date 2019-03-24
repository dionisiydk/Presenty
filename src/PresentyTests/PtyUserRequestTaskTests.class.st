Class {
	#name : #PtyUserRequestTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyUserRequestTaskTests >> taskClass [ 
	^PtyUserRequestTask
]

{ #category : #tests }
PtyUserRequestTaskTests >> testCreationFromBlock [

	| block actual |
	block := ['test block'].
	
	actual := block asUserRequestTask.
	
	actual should beInstanceOf: PtyUserRequestTask.
	actual action should be: block
]

{ #category : #tests }
PtyUserRequestTaskTests >> testExecutionWhenActionExists [

	[	
		task action: #uiActionBlock.
		
		[task body]
			should strictly satisfy: 
		[guide addUIAction: #uiActionBlock.
		guide performUserRequest]
	
	] runWithMocks 
	
]

{ #category : #tests }
PtyUserRequestTaskTests >> testExecutionWhenNoItemsProvided [

	[	
		task presenter: nil.
		task action: nil.
		
		[task body]
			should strictly satisfy: 
		[guide performUserRequest]
	
	] runWithMocks 
	
]

{ #category : #tests }
PtyUserRequestTaskTests >> testExecutionWhenPresenterAndActionExists [

	[	
		task presenter: #presenter.
		task action: #uiActionBlock.
		
		[task body]
			should strictly satisfy: 
		[guide addViewAreaBody: #presenter.
		guide addUIAction: #uiActionBlock.
		guide performUserRequest]
	
	] runWithMocks 
	
]

{ #category : #tests }
PtyUserRequestTaskTests >> testExecutionWhenPresenterExists [

	[	
		task presenter: #presenter.
		
		[task body]
			should strictly satisfy: 
		[guide addViewAreaBody: #presenter.
		guide performUserRequest]
	
	] runWithMocks 
	
]
