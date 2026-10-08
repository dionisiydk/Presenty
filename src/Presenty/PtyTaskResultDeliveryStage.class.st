Class {
	#name : #PtyTaskResultDeliveryStage,
	#superclass : #PtyWorkflowContinuationStage,
	#instVars : [
		'result'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #accessing }
PtyTaskResultDeliveryStage class >> for: aTask withResult: anObject [
	^(self for: aTask)
		result: anObject
]

{ #category : #controlling }
PtyTaskResultDeliveryStage >> continueWorkflow [
	
	^result
]

{ #category : #controlling }
PtyTaskResultDeliveryStage >> prepareWorkflow [
	"The continuation must be resumed at the end because it will restore the original context of the task and then nothing after #resumeContinuation call will be executed"
	task resumeInitialWorkflow.
	task prepareExecutionWorkflow.
	task prepareReturnWorkflow.
	task resumeContinuation
]

{ #category : #accessing }
PtyTaskResultDeliveryStage >> result [
	^result
]

{ #category : #accessing }
PtyTaskResultDeliveryStage >> result: anObject [
	result := anObject
]
