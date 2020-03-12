Class {
	#name : #PtyTaskStartStageTest,
	#superclass : #PtyWorkflowStageTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskStartStageTest >> createWorkflowStage [
	^PtyTaskStartStage for: task
]

{ #category : #tests }
PtyTaskStartStageTest >> testContinueWorkflow [

	| result |
	result := workflowStage continueWorkflow.	
	
	result should beReturnedFrom: [ task startExecution ]
]

{ #category : #tests }
PtyTaskStartStageTest >> testStartingInActiveWorkflow [

	| result |
	result := workflowStage startInActiveWorkflowBy: worker.	
	
	result should beReturnedFrom: [ 
		worker continueWorkflowWithTask: task usingStartStage: workflowStage ]
]

{ #category : #tests }
PtyTaskStartStageTest >> testStartingInInactiveWorkflow [

	| result |
	result := workflowStage startInInactiveWorkflowBy: worker.	
	
	result should beInstanceOf: PtyTaskExecutionFutureResult.
	result task be: task.
	worker should receive startWorkflowWithTask: task usingStartStage: workflowStage
]
