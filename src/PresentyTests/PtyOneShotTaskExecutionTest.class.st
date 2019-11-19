Class {
	#name : #PtyOneShotTaskExecutionTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyOneShotTaskExecutionTest >> createStrategy [
	^PtyOneShotTaskReturnStrategy new
]

{ #category : #tests }
PtyOneShotTaskExecutionTest >> testRequestingTaskExecution [ 

	| result |
	result := executionStrategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]

{ #category : #tests }
PtyOneShotTaskExecutionTest >> testShouldRemoveFromWorkflowTheTaskWhichReturnsResult [ 

	executionStrategy prepareWorkflow: workflow forReturnFrom: task.
	
	workflow should receive removeTask: task
]
