Class {
	#name : #PtyContinueWorkflowTask,
	#superclass : #PtyTask,
	#instVars : [
		'continuationStage',
		'startingTask'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyContinueWorkflowTask class >> for: aTask with: aWorkflowContinuationStage [
	^self new 
		startingTask: aTask;
		continuationStage: aWorkflowContinuationStage
]

{ #category : #execution }
PtyContinueWorkflowTask >> body [
	startingTask jumpToExecutionStage: continuationStage
]

{ #category : #accessing }
PtyContinueWorkflowTask >> continuationStage [
	^ continuationStage
]

{ #category : #accessing }
PtyContinueWorkflowTask >> continuationStage: anObject [
	continuationStage := anObject
]

{ #category : #accessing }
PtyContinueWorkflowTask >> defaultExecutionPriority [ 
	^startingTask executionPriority
]

{ #category : #execution }
PtyContinueWorkflowTask >> startExecution [ 
	"This method should never return 
	because internal call is supposed to resume continuation with specific execution stage"
	self body.
	
	self error: 'It should resume continuation and never return'
]

{ #category : #accessing }
PtyContinueWorkflowTask >> startingTask [
	^ startingTask
]

{ #category : #accessing }
PtyContinueWorkflowTask >> startingTask: anObject [
	startingTask := anObject
]