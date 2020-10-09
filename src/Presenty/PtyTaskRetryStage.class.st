Class {
	#name : #PtyTaskRetryStage,
	#superclass : #PtyWorkflowContinuationStage,
	#category : #Presenty
}

{ #category : #controlling }
PtyTaskRetryStage >> continueWorkflow [

	task resumeInitialWorkflow.
	^task startExecution
]
