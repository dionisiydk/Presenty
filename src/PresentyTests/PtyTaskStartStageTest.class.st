Class {
	#name : #PtyTaskStartStageTest,
	#superclass : #PtyTaskExecutionStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskStartStageTest >> createExecutionStage [
	^PtyTaskStartStage of: task
]

{ #category : #tests }
PtyTaskStartStageTest >> testContinueExecution [

	| result |
	result := executionStage continueExecution.	
	
	result should beReturnedFrom: [ task startExecution ]
]
