Class {
	#name : #PtyTaskStartStageTest,
	#superclass : #PtyWorkflowStageTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyTaskStartStageTest >> createWorkflowStage [
	^PtyTaskStartStage for: task
]

{ #category : #tests }
PtyTaskStartStageTest >> testContinueWorkflowPreparesReturnWorkflowAtTheEnd [

	workflowStage continueWorkflow.	
	
	[ task body. task prepareReturnWorkflow ] should beDoneInOrder
]

{ #category : #tests }
PtyTaskStartStageTest >> testContinueWorkflowReturnsTaskResult [

	| result |
	result := workflowStage continueWorkflow.	
	
	result should beReturnedFrom: [ task body ]
]

{ #category : #tests }
PtyTaskStartStageTest >> testPrepareWorkflow [
	"This method will be resumed with continuation. 
	Therefore it is important that the inital workflow preparation is done first.
	The continuation should not retry it"
	workflowStage prepareWorkflow.

	[ task prepareExecutionWorkflow. task saveContinuation ] should beDoneInOrder 
]
