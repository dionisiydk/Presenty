Class {
	#name : #PtyWorkflowStage,
	#superclass : #Object,
	#instVars : [
		'task'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #'instance creation' }
PtyWorkflowStage class >> for: aTask [
	^self new 
		task: aTask
]

{ #category : #testing }
PtyWorkflowStage class >> isAbstract [ 
	^self = PtyWorkflowStage 
]

{ #category : #execution }
PtyWorkflowStage >> continueWorkflow [
	self subclassResponsibility 
]

{ #category : #accessing }
PtyWorkflowStage >> executionPriority [
	^task executionPriority
]

{ #category : #execution }
PtyWorkflowStage >> prepareWorkflow [
	self subclassResponsibility 
]

{ #category : #printing }
PtyWorkflowStage >> printOn: aStream [
	super printOn: aStream.
	
	aStream nextPut: $(.
	task displayStringOn: aStream.
	aStream nextPut: $).
]

{ #category : #execution }
PtyWorkflowStage >> startNewSession [
	task startNewSession
]

{ #category : #accessing }
PtyWorkflowStage >> task [
	^ task
]

{ #category : #accessing }
PtyWorkflowStage >> task: anObject [
	task := anObject
]

{ #category : #accessing }
PtyWorkflowStage >> workflow [
	^task workflow
]
