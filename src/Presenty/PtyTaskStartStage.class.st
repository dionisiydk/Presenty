Class {
	#name : #PtyTaskStartStage,
	#superclass : #PtyWorkflowStage,
	#category : #'Presenty-Tasks'
}

{ #category : #controlling }
PtyTaskStartStage >> continueWorkflow [
	| result |
	result := task body.
	task prepareReturnWorkflow.
	^result
]

{ #category : #controlling }
PtyTaskStartStage >> prepareWorkflow [
	"This method will be resumed with continuation. 
	Therefore it is important that the inital workflow preparation is done first.
	The continuation should never retry it"
	task prepareExecutionWorkflow.
	task saveContinuation.
]
