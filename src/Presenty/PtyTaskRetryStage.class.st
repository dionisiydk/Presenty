Class {
	#name : #PtyTaskRetryStage,
	#superclass : #PtyWorkflowContinuationStage,
	#category : #'Presenty-Tasks'
}

{ #category : #controlling }
PtyTaskRetryStage >> continueWorkflow [

	task resumeInitialWorkflow.
	^task startExecution
]
