Class {
	#name : #PtyTaskDefermentStage,
	#superclass : #PtyWorkflowContinuationStage,
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyTaskDefermentStage >> continueWorkflow [
	
	^PtyUserRequest signal
	
]
