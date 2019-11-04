Class {
	#name : #PtyTaskResultDeliveryStageTest,
	#superclass : #PtyTaskExecutionStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskResultDeliveryStageTest >> createExecutionStage [
	^PtyTaskResultDeliveryStage of: task withResult: #taskResult
]

{ #category : #tests }
PtyTaskResultDeliveryStageTest >> testContinueExecution [

	| result |
	executionStage result: #taskResult.
	
	result := executionStage continueExecution.	
	
	result should be: #taskResult
]

{ #category : #tests }
PtyTaskResultDeliveryStageTest >> testContinueExecutionShouldPassThrough3Steps [

	executionStage continueExecution.	
	
	[task restoreInitialWorkflow.
	task prepareExecutionWorkflow.
	task prepareReturnWorkflow] should beDoneInOrder 
]
