Class {
	#name : #PtyWorkSession,
	#superclass : #Object,
	#instVars : [
		'parentSession',
		'currentTasks'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyWorkSession >> createNewFor: aTask [ 
	^self copy 
		parentSession: self;
		registerNewTask: aTask;
		yourself
]

{ #category : #accessing }
PtyWorkSession >> currentTasks [
	^ currentTasks
]

{ #category : #accessing }
PtyWorkSession >> currentTasks: anObject [
	currentTasks := anObject
]

{ #category : #initialization }
PtyWorkSession >> initialize [
	super initialize.
	
	currentTasks := OrderedCollection new.
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
	
	currentTasks := currentTasks copy
]

{ #category : #controlling }
PtyWorkSession >> registerNewTask: aTask [
	currentTasks add: aTask
]

{ #category : #controlling }
PtyWorkSession >> removeTask: aTask [ 
	currentTasks remove: aTask
]
