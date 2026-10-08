Class {
	#name : #PtyTaskResultDeliveryStageTest,
	#superclass : #PtyWorkflowContinuationStageTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyTaskResultDeliveryStageTest >> createWorkflowStage [
	^PtyTaskResultDeliveryStage for: task withResult: #taskResult
]

{ #category : #tests }
PtyTaskResultDeliveryStageTest >> testContinueWorkflow [

	| result |
	workflowStage result: #taskResult.
	
	result := workflowStage continueWorkflow.	
	
	result should be: #taskResult
]

{ #category : #tests }
PtyTaskResultDeliveryStageTest >> testPrepareWorkflowShouldSimulateItsStateLikeIfTaskWouldBeExecuted [
	"The continuation must be resumed at the end because it will restore the original context of the task and then nothing after #resumeContinuation call will be executed"
	workflowStage prepareWorkflow.	
	
	[task resumeInitialWorkflow.
	task prepareExecutionWorkflow.
	task prepareReturnWorkflow.
	task resumeContinuation] should beDoneInOrder 
]
