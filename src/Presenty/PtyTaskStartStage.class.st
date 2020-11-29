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

{ #category : #execution }
PtyTaskStartStage >> startInInactiveWorkflowBy: aWorker [

	aWorker startWorkflowWithTask: task usingStartStage: self.
	
	^PtyTaskExecutionFutureResult of: task
]
