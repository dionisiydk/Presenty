Class {
	#name : #PtyTaskRetryStageTest,
	#superclass : #PtyTaskExecutionStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskRetryStageTest >> createExecutionStage [
	^PtyTaskRetryStage of: task
]

{ #category : #tests }
PtyTaskRetryStageTest >> testContinueExecution [

	| result |
	result := executionStage continueExecution.	
	
	result should beReturnedFrom: [ task startExecution ]
]

{ #category : #tests }
PtyTaskRetryStageTest >> testContinueExecutionShouldActivateInitialWorkflowFirst [

	executionStage continueExecution.	
	
	[task activateInitialWorkflow.
	task startExecution] should beDoneInOrder 
]
