Class {
	#name : #PtyWorkflow,
	#superclass : #Object,
	#instVars : [
		'currentTasks',
		'parentWorkflow'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyWorkflow >> createNewFor: aTask [ 
	^self copy 
		parentWorkflow: self;
		registerNewTask: aTask;
		yourself
]

{ #category : #accessing }
PtyWorkflow >> currentTasks [
	^ currentTasks
]

{ #category : #accessing }
PtyWorkflow >> currentTasks: anObject [
	currentTasks := anObject
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
