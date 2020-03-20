Class {
	#name : #PtyTaskResultDeliveryStageTest,
	#superclass : #PtyWorkflowContinuationStageTestCase,
	#category : #'Presenty-Tests'
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
PtyTaskResultDeliveryStageTest >> testContinueWorkflowShouldPassTaskThrough3Steps [

	workflowStage continueWorkflow.	
	
	[task activateInitialWorkflow.
	task prepareExecutionWorkflow.
	task prepareReturnWorkflow] should beDoneInOrder 
]
