Class {
	#name : #PtyTaskRetryStage,
	#superclass : #PtyTaskExecutionStage,
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyTaskRetryStage >> continueExecution [

	task activateInitialWorkflow.
	^task startExecution
]
