Class {
	#name : #PtyTaskRetryStage,
	#superclass : #PtyWorkflowContinuationStage,
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyTaskRetryStage >> continueExecution [

	task activateInitialWorkflow.
	^task startExecution
]
