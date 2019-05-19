Class {
	#name : #PtyOneShotTaskExecutionTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyOneShotTaskExecutionTest >> createStrategy [
	^PtyOneShotTaskExecution new
]

{ #category : #tests }
PtyOneShotTaskExecutionTest >> testExecutingTask [ 

	| result |
	result := executionStrategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]
