Class {
	#name : #PtyWorkflowStage,
	#superclass : #Object,
	#instVars : [
		'task'
	],
	#category : #'Presenty-NewCore'
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

{ #category : #execution }
PtyWorkflowStage >> startInActiveWorkflowBy: aWorker [
	"Using this method the system continues the workflow execution from the current stage to new one (receiver).
	For example when new task is requested from another task Presenty will simply execute it in current process"
	self subclassResponsibility 
]

{ #category : #execution }
PtyWorkflowStage >> startInInactiveWorkflowBy: aWorker [
	"Using this method the system initiates given stage of workflow execution (receiver) from the outside of Presenty context. 
	For example when new task is requested from playground Presenty will start new worker process"
	self subclassResponsibility 
]

{ #category : #accessing }
PtyWorkflowStage >> task [
	^ task
]

{ #category : #accessing }
PtyWorkflowStage >> task: anObject [
	task := anObject
]
