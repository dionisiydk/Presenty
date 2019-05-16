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

{ #category : #'task execution' }
PtyWorkplace >> findPreferredTaskImplementing: requestedTask [
	"Here it should be call to workspace settings"
	^requestedTask copy
]

{ #category : #'task execution' }
PtyWorkplace >> findWorkerRequestingNewTask [
	"Active worker is always one who requesting new tasks because it is executed from active process.
	When it is not exist we assume that it is some implicit worker from the external system
	(external for Presenty). And workplace will create an instance representing it as a result.
	For example user can request new task from playground which is not managed by Presenty context.
	In that case new worker will be created to represent this activity. 
	When this worker will receive a command to execute a task 
	it will became part of workplace environment (it will be added to workplace)"

	^workers 
		detect: [ :each | each isActive ] 
		ifNone: [	PtyWorker atWorkplace: self]
]

{ #category : #initialization }
PtyWorkplace >> initialize [
	super initialize.
	
	activeTasks := OrderedCollection new.
	workers := OrderedCollection new
]

{ #category : #'task execution' }
PtyWorkplace >> planExecutionOf: aTask by: aUser [

	| currentWorker |
	currentWorker := self findWorkerRequestingNewTask.
	
	aTask beRequestedFor: aUser from: currentWorker.
	
	^self findPreferredTaskImplementing: aTask
]

{ #category : #controlling }
PtyWorkplace >> registerActiveTask: aTask [

	self registerWorker: aTask worker.	
	activeTasks add: aTask
]

{ #category : #controlling }
PtyWorkplace >> registerWorker: aWorker [ 

	(workers includes: aWorker) ifTrue: [ ^self ].
	
	workers add: aWorker
]

{ #category : #accessing }
PtyWorkplace >> workers [
	^ workers
]

{ #category : #accessing }
PtyWorkplace >> workers: anObject [
	workers := anObject
]
