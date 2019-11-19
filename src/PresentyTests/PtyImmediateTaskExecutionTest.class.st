Class {
	#name : #PtyImmediateTaskExecutionTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyImmediateTaskExecutionTest >> createStrategy [
	^PtyImmediateExecutionStrategy new
]

{ #category : #tests }
PtyImmediateTaskExecutionTest >> testRequestingTaskExecution [ 

	| result |
	result := strategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]
