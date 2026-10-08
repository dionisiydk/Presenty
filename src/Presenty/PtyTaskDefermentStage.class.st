Class {
	#name : #PtyTaskDefermentStage,
	#superclass : #PtyWorkflowStage,
	#category : #'Presenty-Tasks'
}

{ #category : #controlling }
PtyTaskDefermentStage >> continueWorkflow [
	
	^PtyUserRequest signal
	
]

{ #category : #controlling }
PtyTaskDefermentStage >> prepareWorkflow [
	task saveContinuation
]
