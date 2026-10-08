Class {
	#name : #PtyTaskRetryStage,
	#superclass : #PtyWorkflowContinuationStage,
	#category : #'Presenty-Tasks'
}

{ #category : #controlling }
PtyTaskRetryStage >> continueWorkflow [

	| result |
	result := task body.
	task prepareReturnWorkflow.
	^result
]

{ #category : #controlling }
PtyTaskRetryStage >> prepareWorkflow [

	task resumeInitialWorkflow.
	task prepareExecutionWorkflow.
	task resumeContinuation
]
