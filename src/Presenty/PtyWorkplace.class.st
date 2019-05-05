Class {
	#name : #PtyWorkplace,
	#superclass : #Object,
	#instVars : [
		'activeTasks',
		'workers'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyWorkplace >> activeTasks [
	^ activeTasks
]

{ #category : #accessing }
PtyWorkplace >> activeTasks: anObject [
	activeTasks := anObject
]

{ #category : #accessing }
PtyWorkplace >> addTask: aTask [

	activeTasks add: aTask
]

{ #category : #accessing }
PtyWorkplace >> addWorker: aWorker [ 
	workers add: aWorker
]

{ #category : #initialization }
PtyWorkplace >> initialize [
	super initialize.
	
	activeTasks := OrderedCollection new.
	workers := OrderedCollection new
]

{ #category : #'task execution' }
PtyWorkplace >> planExecutionOf: aTask by: aUser [

	| activeWorker |
	aTask user: aUser.
	
	activeWorker := workers detect: [ :each | each isActive ] ifNone: [ | newWorker |
		newWorker := PtyWorker atWorkplace: self.
		self addWorker: newWorker.
		^aTask prepareExecutionPlan: PtyInitiateNewExecutionPlan by: newWorker].
	
	^aTask prepareExecutionPlan: PtyContinueActiveExecutionPlan by: activeWorker
]

{ #category : #accessing }
PtyWorkplace >> workers [
	^ workers
]

{ #category : #accessing }
PtyWorkplace >> workers: anObject [
	workers := anObject
]
