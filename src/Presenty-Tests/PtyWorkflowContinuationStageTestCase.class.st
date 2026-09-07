Class {
	#name : #PtyWorkflowContinuationStageTestCase,
	#superclass : #PtyWorkflowStageTestCase,
	#category : #'Presenty-Tests-Tasks'
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
