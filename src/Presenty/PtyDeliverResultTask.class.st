Class {
	#name : #PtyDeliverResultTask,
	#superclass : #PtyExecutionControllingTask,
	#instVars : [
		'result'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyDeliverResultTask class >> result: taskResult from: completeTask [

	^(self for: completeTask)
		result: taskResult
]

{ #category : #execution }
PtyDeliverResultTask >> body [
	executingTask jumpToResultDeliveryStageWith: result

]

{ #category : #accessing }
PtyDeliverResultTask >> result [
	^ result
]

{ #category : #accessing }
PtyDeliverResultTask >> result: anObject [
	result := anObject
]
