Class {
	#name : #PtyIndependentExecutionStrategyTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyIndependentExecutionStrategyTest >> createStrategy [
	^PtyIndependentExecutionStrategy new
]

{ #category : #tests }
PtyIndependentExecutionStrategyTest >> testRequestingTaskExecution [ 

	| result |
	result := strategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]
