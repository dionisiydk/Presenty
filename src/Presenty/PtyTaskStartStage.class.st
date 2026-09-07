Class {
	#name : #PtyTaskStartStage,
	#superclass : #PtyWorkflowStage,
	#category : #'Presenty-Tasks'
}

{ #category : #controlling }
PtyTaskStartStage >> continueWorkflow [
	^task startExecution
]

{ #category : #execution }
PtyTaskStartStage >> startInActiveWorkflowBy: aWorker [

	^aWorker continueWorkflowWithTask: task usingStartStage: self
]
