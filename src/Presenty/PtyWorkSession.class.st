Class {
	#name : #PtyWorkSession,
	#superclass : #Object,
	#instVars : [
		'activeTasks',
		'parentSession'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyWorkSession >> activeTasks: anObject [
	activeTasks := anObject
]

{ #category : #controlling }
PtyWorkSession >> createNewFor: aTask [ 
	^self copy 
		parentSession: self;
		registerNewTask: aTask;
		yourself
]

{ #category : #accessing }
PtyWorkSession >> currentTasks [
	^ activeTasks
]

{ #category : #initialization }
PtyWorkSession >> initialize [
	super initialize.
	
	activeTasks := OrderedCollection new.
]

{ #category : #accessing }
PtyWorkSession >> parentSession [
	^ parentSession
]

{ #category : #accessing }
PtyWorkSession >> parentSession: anObject [
	parentSession := anObject
]

{ #category : #copying }
PtyWorkSession >> postCopy [
	super postCopy.
	
	activeTasks := activeTasks copy
]

{ #category : #controlling }
PtyWorkSession >> registerNewTask: aTask [
	activeTasks add: aTask
]

{ #category : #controlling }
PtyWorkSession >> removeTask: aTask [ 
	activeTasks remove: aTask
]
