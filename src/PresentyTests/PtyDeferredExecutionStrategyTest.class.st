Class {
	#name : #PtyDeferredExecutionStrategyTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyDeferredExecutionStrategyTest >> createStrategy [
	^ PtyDeferredExecutionStrategy new
]

{ #category : #tests }
PtyDeferredExecutionStrategyTest >> testShouldDeferTaskUsingWorker [ 

	| result |
	result := strategy requestExecutionOf: task in: workflow.
	
	result should beReturnedFrom: [ workflow deferTask: task ]
]
