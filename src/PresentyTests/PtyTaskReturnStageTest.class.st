Class {
	#name : #PtyTaskReturnStageTest,
	#superclass : #PtyTaskExecutionStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskReturnStageTest >> createExecutionStage [
	^PtyTaskReturnStage of: task withResult: #taskResult
]

{ #category : #tests }
PtyTaskReturnStageTest >> testContinueExecution [

	| result |
	executionStage result: #taskResult.
	
	result := executionStage continueExecution.	
	
	result should be: #taskResult
]
