Class {
	#name : #PtyTaskStartStage,
	#superclass : #PtyWorkflowStage,
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyTaskStartStage >> continueExecution [
	^task startExecution
]

{ #category : #execution }
PtyTaskStartStage >> startInActiveWorkflowBy: aWorker [

	^aWorker continueWithTask: task using: self
]

{ #category : #execution }
PtyTaskStartStage >> startInInactiveWorkflowBy: aWorker [

	aWorker startWithTask: task using: self.
	
	^PtyTaskExecutionFutureResult of: task
]
