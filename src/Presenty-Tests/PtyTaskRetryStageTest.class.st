Class {
	#name : #PtyTaskRetryStageTest,
	#superclass : #PtyWorkflowContinuationStageTestCase,
	#category : #'Presenty-Tests-Tasks'
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
	
	[task resumeInitialWorkflow.
	task startExecution] should beDoneInOrder 
]
