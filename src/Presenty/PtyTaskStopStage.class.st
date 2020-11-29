Class {
	#name : #PtyTaskStopStage,
	#superclass : #PtyWorkflowStage,
	#category : #'Presenty-Tasks'
}

{ #category : #execution }
PtyTaskStopStage >> continueWorkflow [
	self shouldNotImplement 
]

{ #category : #execution }
PtyTaskStopStage >> startInActiveWorkflowBy: aWorker [
	
	task stopWorkSession.
	aWorker stopWorkflow.
]

{ #category : #execution }
PtyTaskStopStage >> startInInactiveWorkflowBy: aWorker [
	
	aWorker stopWorkflow.
	task stopWorkSession
]
