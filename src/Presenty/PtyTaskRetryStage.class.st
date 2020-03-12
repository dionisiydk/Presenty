Class {
	#name : #PtyTaskRetryStage,
	#superclass : #PtyWorkflowContinuationStage,
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyTaskRetryStage >> continueWorkflow [

	task activateInitialWorkflow.
	^task startExecution
]
