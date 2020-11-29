Class {
	#name : #PtyTaskStopStageTest,
	#superclass : #PtyWorkflowStageTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyTaskStopStageTest >> createWorkflowStage [
	^PtyTaskStopStage for: task
]

{ #category : #tests }
PtyTaskStopStageTest >> testStartingInActiveWorkflow [

	workflowStage startInActiveWorkflowBy: worker.	
	
	[task stopWorkSession.
	worker stopWorkflow] should beDoneInOrder
]

{ #category : #tests }
PtyTaskStopStageTest >> testStartingInInactiveWorkflow [

	workflowStage startInInactiveWorkflowBy: worker.	
	
	[worker stopWorkflow.
	task stopWorkSession] should beDoneInOrder
]
