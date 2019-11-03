Class {
	#name : #PtyTaskResultDeliveryStage,
	#superclass : #PtyTaskExecutionStage,
	#instVars : [
		'result'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyTaskResultDeliveryStage class >> of: aTask withResult: anObject [
	^(self of: aTask)
		result: anObject
]

{ #category : #controlling }
PtyTaskResultDeliveryStage >> continueExecution [
	
	task restoreWorkplaceState.
	
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
