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
PtyOneShotTaskExecutionTest >> testCompletingTaskExecution [ 

	executionStrategy completeExecutionOf: task using: worker.
	
	worker should receive removeTask: task
]

{ #category : #tests }
PtyOneShotTaskExecutionTest >> testRequestingTaskExecution [ 

	| result |
	result := executionStrategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]
