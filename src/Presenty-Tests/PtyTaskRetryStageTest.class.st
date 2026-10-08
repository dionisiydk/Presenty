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
PtyTaskRetryStageTest >> testContinueWorkflowPreparesReturnWorkflowAtTheEnd [

	workflowStage continueWorkflow.	
	
	[ task body. task prepareReturnWorkflow ] should beDoneInOrder
]

{ #category : #tests }
PtyTaskRetryStageTest >> testContinueWorkflowReturnsTaskResult [

	| result |
	result := workflowStage continueWorkflow.	
	
	result should beReturnedFrom: [ task body ]
]

{ #category : #tests }
PtyTaskRetryStageTest >> testPrepareWorkflowShouldSimulateItsStateLikeIfTaskWouldBeExecuted [
	"The continuation must be resumed at the end because it will restore the original context of the task and then nothing after #resumeContinuation call will be executed"
	workflowStage prepareWorkflow.	
	
	[task resumeInitialWorkflow.
	task prepareExecutionWorkflow.
	task resumeContinuation] should beDoneInOrder
]
