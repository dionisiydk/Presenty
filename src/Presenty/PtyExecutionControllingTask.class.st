Class {
	#name : #PtyExecutionControllingTask,
	#superclass : #PtyTask,
	#instVars : [
		'executingTask'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyExecutionControllingTask class >> for: aTask [
	^self new 
		executingTask: aTask
]

{ #category : #accessing }
PtyExecutionControllingTask >> defaultExecutionPriority [ 
	^executingTask executionPriority
]

{ #category : #accessing }
PtyExecutionControllingTask >> executingTask [
	^ executingTask
]

{ #category : #accessing }
PtyExecutionControllingTask >> executingTask: anObject [
	executingTask := anObject
]

{ #category : #execution }
PtyExecutionControllingTask >> startExecution [ 
	"This method should never return 
	because internal call is supposed to resume continuation with specific execution stage"
	self body.
	
	self error: 'It should resume continuation and never return'
]
