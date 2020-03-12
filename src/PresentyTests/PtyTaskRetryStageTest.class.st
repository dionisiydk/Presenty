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
PtyTaskRetryStageTest >> testContinueWorkflow [

	| result |
	result := workflowStage continueWorkflow.	
	
	result should beReturnedFrom: [ task startExecution ]
]

{ #category : #tests }
PtyTaskRetryStageTest >> testContinueWorkflowShouldFirstActivateInitialWorkflow [

	workflowStage continueWorkflow.	
	
	[task activateInitialWorkflow.
	task startExecution] should beDoneInOrder 
]
