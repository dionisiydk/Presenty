Class {
	#name : #PtyImmediateTaskExecutionTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyImmediateTaskExecutionTest >> createStrategy [
	^PtyImmediateTaskExecution new
]

{ #category : #tests }
PtyImmediateTaskExecutionTest >> testExecutingTask [ 

	| result |
	result := executionStrategy execute: task using: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]
