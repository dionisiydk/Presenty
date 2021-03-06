Class {
	#name : #PtyImmediateExecutionStrategyTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyImmediateExecutionStrategyTest >> createStrategy [
	^PtyImmediateExecutionStrategy new
]

{ #category : #tests }
PtyImmediateExecutionStrategyTest >> testShouldExecuteTaskUsingWorker [ 

	| result |
	result := strategy requestExecutionOf: task in: workflow.
	
	result should beReturnedFrom: [workflow executeTask: task]
]
