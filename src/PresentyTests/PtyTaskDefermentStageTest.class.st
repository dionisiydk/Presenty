Class {
	#name : #PtyTaskDefermentStageTest,
	#superclass : #PtyTaskExecutionStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskDefermentStageTest >> createExecutionStage [
	^PtyTaskDefermentStage of: task
]

{ #category : #tests }
PtyTaskDefermentStageTest >> testContinueExecution [

	[executionStage continueExecution] should raise: PtyUserRequest
]
