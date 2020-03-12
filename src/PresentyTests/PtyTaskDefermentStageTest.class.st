Class {
	#name : #PtyTaskDefermentStageTest,
	#superclass : #PtyWorkflowStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskDefermentStageTest >> createWorkflowStage [
	^PtyTaskDefermentStage for: task
]

{ #category : #tests }
PtyTaskDefermentStageTest >> testContinueWorkflow [

	[workflowStage continueWorkflow] should raise: PtyUserRequest
]

{ #category : #tests }
PtyTaskDefermentStageTest >> testStartingInActiveWorkflow [

	| result |
	result := workflowStage startInActiveWorkflowBy: worker.	
	
	result should beReturnedFrom: [ 
		worker continueWorkflowWithTask: task usingStartStage: workflowStage ]
]

{ #category : #tests }
PtyTaskDefermentStageTest >> testStartingInInactiveWorkflowShouldDoNothing [

	workflowStage startInInactiveWorkflowBy: nil
]
