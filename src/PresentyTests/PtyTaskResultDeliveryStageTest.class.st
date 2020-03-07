Class {
	#name : #PtyTaskResultDeliveryStageTest,
	#superclass : #PtyWorkflowContinuationStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskResultDeliveryStageTest >> createWorkflowStage [
	^PtyTaskResultDeliveryStage for: task withResult: #taskResult
]

{ #category : #tests }
PtyTaskResultDeliveryStageTest >> testContinueExecution [

	| result |
	workflowStage result: #taskResult.
	
	result := workflowStage continueExecution.	
	
	result should be: #taskResult
]

{ #category : #tests }
PtyTaskResultDeliveryStageTest >> testContinueExecutionShouldPassThrough3Steps [

	workflowStage continueExecution.	
	
	[task activateInitialWorkflow.
	task prepareExecutionWorkflow.
	task prepareReturnWorkflow] should beDoneInOrder 
]
