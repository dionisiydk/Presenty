Class {
	#name : #PtyDeliverResultTask,
	#superclass : #PtyTask,
	#instVars : [
		'completeTask',
		'result'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyDeliverResultTask class >> result: taskResult from: completeTask [

	^self new 
		completeTask: completeTask;
		result: taskResult
]

{ #category : #execution }
PtyDeliverResultTask >> body [
	"This method never return because internal call will resume continuation"
	completeTask jumpToResultDeliveryStageWith: result

]

{ #category : #accessing }
PtyDeliverResultTask >> completeTask [
	^ completeTask
]

{ #category : #accessing }
PtyDeliverResultTask >> completeTask: anObject [
	completeTask := anObject
]

{ #category : #accessing }
PtyDeliverResultTask >> defaultExecutionPriority [ 
	^completeTask executionPriority
]

{ #category : #accessing }
PtyDeliverResultTask >> result [
	^ result
]

{ #category : #accessing }
PtyDeliverResultTask >> result: anObject [
	result := anObject
]

{ #category : #execution }
PtyDeliverResultTask >> startExecution [ 

	self body
]
