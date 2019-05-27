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
	"Normally this method will never return because following call will resume continuation"
	completeTask completeExecutionWith: result
	


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
