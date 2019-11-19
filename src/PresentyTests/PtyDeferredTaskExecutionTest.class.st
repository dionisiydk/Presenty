Class {
	#name : #PtyDeferredTaskExecutionTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyDeferredTaskExecutionTest >> createStrategy [
	^ PtyDeferredExecutionStrategy new
]

{ #category : #tests }
PtyDeferredTaskExecutionTest >> testRequestingTaskExecution [ 

	| result |
	result := strategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [ worker deferTask: task ]
]
