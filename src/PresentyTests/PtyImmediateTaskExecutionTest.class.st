Class {
	#name : #PtyImmediateTaskExecutionTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyImmediateTaskExecutionTest >> createStrategy [
	^PtyImmediateTaskExecutionStrategy new
]

{ #category : #tests }
PtyImmediateTaskExecutionTest >> testRequestingTaskExecution [ 

	| result |
	result := executionStrategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]
