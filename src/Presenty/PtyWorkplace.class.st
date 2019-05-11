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
	
	activeWorker := workers detect: [ :each | each isActive ] ifNone: [
		PtyWorker atWorkplace: self].
	self activeWorkerOrNewOne.
	aTask 	user: aUser.
	aTask 	worker: activeWorker.
	aTask beRequestedFor: aUser from: activeWorker.
	
	^self preferredTaskFor: aTask
]

{ #category : #'task execution' }
PtyWorkplace >> preferredTaskFor: requestedTask [
	"Here it should be call to workspace settings"
	^requestedTask copy
]

{ #category : #accessing }
PtyWorkplace >> workers [
	^ workers
]

{ #category : #accessing }
PtyWorkplace >> workers: anObject [
	workers := anObject
]
