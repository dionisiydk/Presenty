Class {
	#name : #PtyImmediateExecutionStrategyTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyImmediateExecutionStrategyTest >> createStrategy [
	^PtyImmediateExecutionStrategy new
]

{ #category : #tests }
PtyImmediateExecutionStrategyTest >> testShouldExecuteTaskUsingWorker [ 

	| result |
	result := strategy requestExecutionOf: task in: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]
