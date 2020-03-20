Class {
	#name : #PtyWorkplace,
	#superclass : #Object,
	#instVars : [
		'workers',
		'defaultTaskExecutionPriority',
		'currentWorkflow'
	],
	#category : #Presenty
}

{ #category : #accessing }
PtyWorkplace >> currentTasks [
	^ currentWorkflow allCurrentTasks
]

{ #category : #accessing }
PtyWorkplace >> currentWorkflow [
	^ currentWorkflow
]

{ #category : #accessing }
PtyWorkplace >> currentWorkflow: anObject [
	currentWorkflow := anObject
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
PtyWorkplace >> findActiveWorkflowIfNone: noneBlock [
	
	^currentWorkflow findActiveWorkflowIfNone: noneBlock
]

{ #category : #'task execution' }
PtyWorkplace >> findActiveWorkflowOrCreateNewOne [
	"Active workflow is one which task is currently executing.
	When it is not exist we create new one with new servicing worker.
	For example user can request new task from playground which is not managed by Presenty context.
	In that case new workflow and new worker will be created to represent this activity"

	^self findActiveWorkflowIfNone: [ 
		currentWorkflow spawnNew
			worker: (PtyWorker inWorkplace: self);
			yourself	]
]

{ #category : #'task execution' }
PtyWorkplace >> findPreferredTaskImplementing: requestedTask [
	"Here it should be call to workspace settings"
	^requestedTask
]

{ #category : #initialization }
PtyWorkplace >> initialize [
	super initialize.
	
	workers := OrderedCollection new.
	defaultTaskExecutionPriority := Processor userBackgroundPriority.
	currentWorkflow := PtyWorkflow new
]

{ #category : #'task execution' }
PtyWorkplace >> planExecutionOf: aTask by: aUser [

	aTask user: aUser.
	aTask assignToActiveWorkflowIn: self. 
		
	^self findPreferredTaskImplementing: aTask
]

{ #category : #controlling }
PtyWorkplace >> registerWorker: aWorker [ 

	(workers includes: aWorker) ifTrue: [ ^self ].
	
	workers add: aWorker
]

{ #category : #controlling }
PtyWorkplace >> removeAllTasks [
	currentWorkflow removeAllTasks
]

{ #category : #accessing }
PtyWorkplace >> withActiveWorkerDo: aBlock ifNone: absentBlock [

	^workers 
		detect: [ :each | each isActive ] 
		ifFound: aBlock 
		ifNone: absentBlock
]

{ #category : #accessing }
PtyWorkplace >> workers [
	^ workers
]

{ #category : #accessing }
PtyWorkplace >> workers: anObject [
	workers := anObject
]
