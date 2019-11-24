Class {
	#name : #PtyWorkflow,
	#superclass : #Object,
	#instVars : [
		'parentWorkflow',
		'currentTasks',
		'spawnedWorkflows'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyWorkflow >> activateAs: aWorkflow [

	currentTasks := aWorkflow currentTasks copy.
	spawnedWorkflows := aWorkflow spawnedWorkflows copy.
	parentWorkflow notNil & (parentWorkflow ~= aWorkflow parentWorkflow) ifTrue: [ 
		parentWorkflow removeSpawnedWorkflow: self ].
	parentWorkflow := aWorkflow parentWorkflow.
	parentWorkflow ifNotNil: [ parentWorkflow activateWithSpawnedWorkflow: self ]
]

{ #category : #controlling }
PtyWorkflow >> activateWithSpawnedWorkflow: aWorkflow [

	(spawnedWorkflows includes: aWorkflow) ifFalse: [ 
		spawnedWorkflows add: aWorkflow ].
	
	parentWorkflow ifNotNil: [ parentWorkflow activateWithSpawnedWorkflow: self ]
]

{ #category : #accessing }
PtyWorkflow >> allCurrentTasks [

	^currentTasks, (spawnedWorkflows flatCollect: [ :each | each allCurrentTasks ])
]

{ #category : #controlling }
PtyWorkflow >> captureStateForNewTask [
	^self copy
]

{ #category : #accessing }
PtyWorkflow >> currentTasks [
	^ currentTasks
]

{ #category : #accessing }
PtyWorkflow >> currentTasks: anObject [
	currentTasks := anObject
]

{ #category : #testing }
PtyWorkflow >> includesTask: aTask [
	^currentTasks includes: aTask
]

{ #category : #initialization }
PtyWorkflow >> initialize [
	super initialize.
	
	currentTasks := OrderedCollection new.
	spawnedWorkflows := OrderedCollection new
]

{ #category : #testing }
PtyWorkflow >> isSpawnedFrom: aWorkflow [ 
	parentWorkflow ifNil: [ ^false ].
	
	^parentWorkflow = aWorkflow or: [ parentWorkflow isSpawnedFrom: aWorkflow ]
]

{ #category : #accessing }
PtyWorkflow >> parentWorkflow [
	^ parentWorkflow
]

{ #category : #accessing }
PtyWorkflow >> parentWorkflow: anObject [
	parentWorkflow := anObject
]

{ #category : #copying }
PtyWorkflow >> postCopy [
	super postCopy.
	
	currentTasks := currentTasks copy.
	spawnedWorkflows := spawnedWorkflows copy
]

{ #category : #controlling }
PtyWorkflow >> registerNewTask: aTask [
	currentTasks add: aTask
]

{ #category : #controlling }
PtyWorkflow >> removeAllTasks [

	currentTasks removeAll.
	spawnedWorkflows removeAll
]

{ #category : #controlling }
PtyWorkflow >> removeSpawnedWorkflow: aWorkflow [

	spawnedWorkflows remove: aWorkflow
]

{ #category : #controlling }
PtyWorkflow >> removeTask: aTask [ 
	currentTasks remove: aTask
]

{ #category : #controlling }
PtyWorkflow >> spawnNew [
	| newWorkflow |
	newWorkflow := self class new.
	newWorkflow parentWorkflow: self.
	spawnedWorkflows add: newWorkflow.
	^newWorkflow
]

{ #category : #accessing }
PtyWorkflow >> spawnedWorkflows [
	^ spawnedWorkflows
]

{ #category : #accessing }
PtyWorkflow >> spawnedWorkflows: anObject [
	spawnedWorkflows := anObject
]
