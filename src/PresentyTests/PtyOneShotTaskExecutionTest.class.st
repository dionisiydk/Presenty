Class {
	#name : #PtyOneShotTaskExecutionTest,
	#superclass : #PtyTaskReturnStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyOneShotTaskExecutionTest >> createStrategy [
	^PtyOneShotTaskReturnStrategy new
]

{ #category : #tests }
PtyOneShotTaskExecutionTest >> testRequestingTaskExecution [ 

	| result |
	result := strategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [worker executeTask: task]
]

{ #category : #tests }
PtyOneShotTaskExecutionTest >> testShouldRemoveFromWorkflowTheTaskWhichReturnsResult [ 

	strategy prepareWorkflow: workflow forReturnFrom: task.
	
	workflow should receive removeTask: task
]
