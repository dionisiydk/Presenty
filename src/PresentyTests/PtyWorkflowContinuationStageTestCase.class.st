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

	workflowStage startInActiveWorkflowBy: worker.	
	
	task should receive jumpToWorkflowStage: workflowStage
]

{ #category : #tests }
PtyWorkflowContinuationStageTestCase >> testStartingInInactiveWorkflowShouldReturnFutureResult [

	| result |
	result := workflowStage startInInactiveWorkflowBy: worker.	
	
	result should beInstanceOf: PtyTaskExecutionFutureResult.
	result task be: task
]

{ #category : #tests }
PtyWorkflowContinuationStageTestCase >> testStartingInInactiveWorkflowShouldStartItWithSpecialTask [

	worker stub startWorkflowWithTask: Arg startedTask.
	
	workflowStage startInInactiveWorkflowBy: worker.	
	
	Arg startedTask should beInstanceOf: PtyContinueWorkflowTask.
	Arg startedTask where startingTask should be: task.
	Arg startedTask where continuationStage should be: workflowStage.
]
