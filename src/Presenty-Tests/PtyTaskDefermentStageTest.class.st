Class {
	#name : #PtyTaskDefermentStageTest,
	#superclass : #PtyWorkflowStageTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyTaskDefermentStageTest >> createWorkflowStage [
	^PtyTaskDefermentStage for: task
]

{ #category : #tests }
PtyTaskDefermentStageTest >> testContinueWorkflow [

	[workflowStage continueWorkflow] should raise: PtyUserRequest
]

{ #category : #tests }
PtyTaskDefermentStageTest >> testPrepareWorkflowShouldSaveContinuation [

	workflowStage prepareWorkflow.
	
	task should receive saveContinuation
]
