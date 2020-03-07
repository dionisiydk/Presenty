Class {
	#name : #PtyWorkflowContinuationStageTestCase,
	#superclass : #PtyWorkflowStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #testing }
PtyWorkflowContinuationStageTestCase class >> isAbstract [ 
	^self = PtyWorkflowContinuationStageTestCase
]

{ #category : #tests }
PtyWorkflowContinuationStageTestCase >> testStartingInActiveWorkflow [

	| result |
	result := workflowStage startInActiveWorkflowBy: worker.	
	
	result should beReturnedFrom: [ task jumpToExecutionStage: workflowStage ]
]

{ #category : #tests }
PtyWorkflowContinuationStageTestCase >> testStartingInInactiveWorkflowShouldReturnFutureResult [

	| result |
	result := workflowStage startInInactiveWorkflowBy: worker.	
	
	result should beInstanceOf: PtyTaskExecutionFutureResult.
	result task be: task
]

{ #category : #tests }
PtyWorkflowContinuationStageTestCase >> testStartingInInactiveWorkflowShouldStartSpecialTask [

	worker stub startWithTask: Arg startedTask.
	
	workflowStage startInInactiveWorkflowBy: worker.	
	
	Arg startedTask should beInstanceOf: PtyContinueWorkflowTask.
	Arg startedTask where startingTask should be: task.
	Arg startedTask where continuationStage should be: workflowStage.
]
