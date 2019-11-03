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
PtyTaskResultDeliveryStageTest >> testContinueExecutionShouldRestoreWorkflow [

	executionStage continueExecution.	
	
	[task restoreWorkplaceState] should beDoneInOrder 
]
