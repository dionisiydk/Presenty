Class {
	#name : #PtyWorkplace,
	#superclass : #Object,
	#instVars : [
		'workers',
		'currentWorkSession',
		'defaultTaskExecutionPriority'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyWorkplace >> captureInitialWorkflowFor: aTask [

	^currentWorkSession captureInitialWorkflowFor: aTask
]

{ #category : #accessing }
PtyWorkplace >> currentTasks [
	^ currentWorkSession currentTasks
]

{ #category : #accessing }
PtyWorkplace >> currentWorkSession [
	^ currentWorkSession
]

{ #category : #accessing }
PtyWorkplace >> currentWorkSession: anObject [
	currentWorkSession := anObject
]

{ #category : #accessing }
PtyWorkplace >> defaultTaskExecutionPriority [
	^ defaultTaskExecutionPriority
]

{ #category : #accessing }
PtyWorkplace >> defaultTaskExecutionPriority: anObject [
	defaultTaskExecutionPriority := anObject
]

{ #category : #'task execution' }
PtyWorkplace >> findPreferredTaskImplementing: requestedTask [
	"Here it should be call to workspace settings"
	^requestedTask
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
	
	workers := OrderedCollection new.
	defaultTaskExecutionPriority := Processor userBackgroundPriority.
	currentWorkSession := PtyWorkSession new
]

{ #category : #'task execution' }
PtyWorkplace >> planExecutionOf: aTask by: aUser [

	| currentWorker |
	currentWorker := self findWorkerRequestingNewTask.
	
	aTask beRequestedFor: aUser from: currentWorker.
	
	^self findPreferredTaskImplementing: aTask
]

{ #category : #controlling }
PtyWorkplace >> registerNewTask: aTask [

	currentWorkSession registerNewTask: aTask
]

{ #category : #controlling }
PtyWorkplace >> registerWorker: aWorker [ 

	(workers includes: aWorker) ifTrue: [ ^self ].
	
	workers add: aWorker
]

{ #category : #controlling }
PtyWorkplace >> removeTask: aTask [

	currentWorkSession removeTask: aTask
]

{ #category : #controlling }
PtyWorkplace >> startWorkSessionBy: aWorker [

	self registerWorker: aWorker.
	currentWorkSession := currentWorkSession spawnWithNewTask: aWorker currentTask
]

{ #category : #accessing }
PtyWorkplace >> workers [
	^ workers
]

{ #category : #accessing }
PtyWorkplace >> workers: anObject [
	workers := anObject
]
