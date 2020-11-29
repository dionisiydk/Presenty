Class {
	#name : #PtyContinueWorkflowTask,
	#superclass : #PtyTask,
	#instVars : [
		'continuationStage',
		'startingTask'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #'instance creation' }
PtyContinueWorkflowTask class >> for: aTask with: aWorkflowContinuationStage [
	^self new 
		startingTask: aTask;
		continuationStage: aWorkflowContinuationStage
]

{ #category : #execution }
PtyContinueWorkflowTask >> body [
	startingTask jumpToWorkflowStage: continuationStage
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

{ #category : #controlling }
PtyContinueWorkflowTask >> startNewSession [
	startingTask startNewSession
]

{ #category : #accessing }
PtyContinueWorkflowTask >> startingTask [
	^ startingTask
]

{ #category : #accessing }
PtyContinueWorkflowTask >> startingTask: anObject [
	startingTask := anObject
]
