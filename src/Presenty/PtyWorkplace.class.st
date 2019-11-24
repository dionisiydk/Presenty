Class {
	#name : #PtyWorkplace,
	#superclass : #Object,
	#instVars : [
		'workers',
		'defaultTaskExecutionPriority',
		'currentWorkflow'
	],
	#category : #'Presenty-NewCore'
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
PtyWorkplace >> findPreferredTaskImplementing: requestedTask [
	"Here it should be call to workspace settings"
	^requestedTask
]

{ #category : #'task execution' }
PtyWorkplace >> findWorkerExecutingCurrentTask [
	"Active worker is always one who executes current task because it is executed from active process.
	When it is not exist we assume that it is some implicit worker from the external system
	(external for Presenty). And workplace will create an instance representing it as a result.
	For example user can request new task from playground which is not managed by Presenty context.
	In that case new worker will be created to represent this activity. 
	When this worker will receive a command to execute a task 
	it will became part of workplace environment (it will be added to workplace)"

	^self 	withActiveWorkerDo: [ :worker | worker ] ifNone: [ PtyWorker atWorkplace: self]
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
	aTask workplace: self.
	self 
		withActiveWorkerDo: [ :activeWorker | aTask parentTask: activeWorker activeTask ]
		ifNone: [ aTask workflow: currentWorkflow spawnNew ].
		
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
