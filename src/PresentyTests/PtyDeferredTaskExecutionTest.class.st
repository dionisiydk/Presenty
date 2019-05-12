Class {
	#name : #PtyDeferredTaskExecutionTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyDeferredTaskExecutionTest >> createStrategy [
	^ PtyDeferredTaskExecution new
]

{ #category : #tests }
PtyDeferredTaskExecutionTest >> testExecutingTask [ 

	executionStrategy execute: task using: worker.
	
	worker should receive deferTask: task
]
