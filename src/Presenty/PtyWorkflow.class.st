Class {
	#name : #PtyWorkflow,
	#superclass : #Object,
	#instVars : [
		'workSession',
		'parentWorkflow',
		'currentTasks'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #evaluating }
PtyWorkflow class >> in: aWorkSession [
	^self new 
		workSession: aWorkSession
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
	
	currentTasks := currentTasks copy
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
PtyWorkflow >> spawnForNewTask [
	^self copy 
		parentWorkflow: self;
		yourself
]

{ #category : #accessing }
PtyWorkflow >> workSession [
	^ workSession
]

{ #category : #accessing }
PtyWorkflow >> workSession: anObject [
	workSession := anObject
]
