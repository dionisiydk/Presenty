Class {
	#name : #PtyWorkSession,
	#superclass : #Object,
	#instVars : [
		'parentSession',
		'workflows'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyWorkSession >> addNewWorkflow [

	^self addWorkflow: (PtyWorkflow in: self)
]

{ #category : #accessing }
PtyWorkSession >> addWorkflow: aWorkflow [
	^workflows add: aWorkflow
]

{ #category : #accessing }
PtyWorkSession >> currentTasks [
	^workflows flatCollect: [ :each | each currentTasks ]
]

{ #category : #accessing }
PtyWorkSession >> findActiveWorkflowSpawned: aWorkflow [
	
	| targetWorkflow |
	targetWorkflow := aWorkflow parentWorkflow.
	(workflows includes: targetWorkflow) ifFalse: [ 
		^self error: 'Active workflow not found'].
	 ^targetWorkflow
]

{ #category : #initialization }
PtyWorkSession >> initialize [ 
	super initialize.
	
	workflows := OrderedCollection new
]

{ #category : #accessing }
PtyWorkSession >> parentSession [
	^ parentSession
]

{ #category : #accessing }
PtyWorkSession >> parentSession: anObject [
	parentSession := anObject
]

{ #category : #controlling }
PtyWorkSession >> postCopy [
	super postCopy.
	
	workflows := workflows copy
]

{ #category : #controlling }
PtyWorkSession >> registerNewTask: aTask [
	
	| targetWorkflow |
	targetWorkflow := self findActiveWorkflowSpawned: aTask initialWorkflow.
	 
	targetWorkflow registerNewTask: aTask
]

{ #category : #controlling }
PtyWorkSession >> removeTask: aTask [
	
	| targetWorkflow |
	targetWorkflow := self findActiveWorkflowSpawned: aTask initialWorkflow.
	 
	targetWorkflow removeTask: aTask
]

{ #category : #controlling }
PtyWorkSession >> spawnWithNewTask: aTask [

	| newSession |
	newSession := self copy.
	newSession parentSession: self.
	newSession registerNewTask: aTask.
	^newSession

	
]

{ #category : #accessing }
PtyWorkSession >> workflowWith: aTask [
	^workflows detect: [ :each | each includesTask: aTask ]
]

{ #category : #accessing }
PtyWorkSession >> workflows [
	^ workflows
]

{ #category : #accessing }
PtyWorkSession >> workflows: anObject [
	workflows := anObject
]
