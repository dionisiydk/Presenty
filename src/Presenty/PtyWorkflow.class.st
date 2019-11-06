Class {
	#name : #PtyWorkflow,
	#superclass : #Object,
	#instVars : [
		'workSession',
		'parentWorkflow',
		'currentTasks',
		'forkedWorkflows'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #evaluating }
PtyWorkflow class >> in: aWorkSession [
	^self new 
		workSession: aWorkSession
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

{ #category : #accessing }
PtyWorkflow >> forkedWorkflows [
	^ forkedWorkflows
]

{ #category : #accessing }
PtyWorkflow >> forkedWorkflows: anObject [
	forkedWorkflows := anObject
]

{ #category : #testing }
PtyWorkflow >> includesTask: aTask [
	^currentTasks includes: aTask
]

{ #category : #initialization }
PtyWorkflow >> initialize [
	super initialize.
	
	currentTasks := OrderedCollection new.
	forkedWorkflows := OrderedCollection new
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
	forkedWorkflows := forkedWorkflows copy
]

{ #category : #controlling }
PtyWorkflow >> registerNewTask: aTask [
	currentTasks add: aTask
]

{ #category : #controlling }
PtyWorkflow >> removeTask: aTask [ 
	currentTasks remove: aTask
]

{ #category : #controlling }
PtyWorkflow >> revertStateTo: aWorkflow [

	currentTasks := aWorkflow currentTasks copy.
	workSession revertStateTo: aWorkflow workSession startingAt: self.
]

{ #category : #controlling }
PtyWorkflow >> spawnNew [
	| newWorkflow |
	newWorkflow := self class in: workSession.
	newWorkflow parentWorkflow: self.
	forkedWorkflows add: newWorkflow.
	workSession addWorkflow: newWorkflow.
	^newWorkflow
]

{ #category : #accessing }
PtyWorkflow >> workSession [
	^ workSession
]

{ #category : #accessing }
PtyWorkflow >> workSession: anObject [
	workSession := anObject
]
