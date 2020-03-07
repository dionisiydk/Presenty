Class {
	#name : #PtyTaskRetryStageTest,
	#superclass : #PtyWorkflowContinuationStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskRetryStageTest >> createWorkflowStage [
	^PtyTaskRetryStage for: task
]

{ #category : #tests }
PtyTaskRetryStageTest >> testContinueExecution [

	| result |
	result := workflowStage continueExecution.	
	
	result should beReturnedFrom: [ task startExecution ]
]

{ #category : #tests }
PtyTaskRetryStageTest >> testContinueExecutionShouldActivateInitialWorkflowFirst [

	workflowStage continueExecution.	
	
	[task activateInitialWorkflow.
	task startExecution] should beDoneInOrder 
]
