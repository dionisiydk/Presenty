Class {
	#name : #PtyTaskDefermentStageTest,
	#superclass : #PtyWorkflowContinuationStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskDefermentStageTest >> createWorkflowStage [
	^PtyTaskDefermentStage for: task
]

{ #category : #tests }
PtyTaskDefermentStageTest >> testContinueWorkflow [

	[workflowStage continueWorkflow] should raise: PtyUserRequest
]
