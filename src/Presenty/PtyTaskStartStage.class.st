Class {
	#name : #PtyTaskStartStage,
	#superclass : #PtyWorkflowStage,
	#category : #'Presenty-NewCore'
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

	aWorker startWithTask: task using: self.
	
	^PtyTaskExecutionFutureResult of: task
]
