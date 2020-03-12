Class {
	#name : #PtyTaskResultDeliveryStage,
	#superclass : #PtyWorkflowContinuationStage,
	#instVars : [
		'result'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyTaskResultDeliveryStage class >> for: aTask withResult: anObject [
	^(self for: aTask)
		result: anObject
]

{ #category : #controlling }
PtyTaskResultDeliveryStage >> continueWorkflow [
	
	task activateInitialWorkflow.
	task prepareExecutionWorkflow.
	task prepareReturnWorkflow.
	
	^result
]

{ #category : #accessing }
PtyTaskResultDeliveryStage >> result [
	^result
]

{ #category : #accessing }
PtyTaskResultDeliveryStage >> result: anObject [
	result := anObject
]
