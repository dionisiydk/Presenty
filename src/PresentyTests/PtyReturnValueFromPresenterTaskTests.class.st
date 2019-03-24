Class {
	#name : #PtyReturnValueFromPresenterTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyReturnValueFromPresenterTaskTests >> taskClass [

	^PtyReturnValueFromPresenterTask
]

{ #category : #tests }
PtyReturnValueFromPresenterTaskTests >> testExecution [

	[:presenter :taskContext |
		task presenter:  presenter.
		task result: #result.
		
		[task body]
			should strictly satisfy: 
		[presenter context willReturn: taskContext.
		taskContext return: #result].
				
	] runWithMocks 
]
