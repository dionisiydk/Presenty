Class {
	#name : #PtyTaskDefermentStage,
	#superclass : #PtyWorkflowContinuationStage,
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyTaskDefermentStage >> continueExecution [
	
	^PtyUserRequest signal
	
]
