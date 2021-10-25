Class {
	#name : #PtyWorkplace,
	#superclass : #Object,
	#instVars : [
		'defaultTaskExecutionPriority',
		'currentWorkflow',
		'settings',
		'devices',
		'announcer',
		'user'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #accessing }
PtyWorkplace >> addDevice: aDevice [
	aDevice workplace: self.
	devices add: aDevice.
	^aDevice
]

{ #category : #controlling }
PtyWorkplace >> close [
	devices do: [:each | each detachFromWorkplace ]
]

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

{ #category : #accessing }
PtyWorkplace >> deviceLike: aDeviceClass [
	
	^devices detect: [ :each | each isKindOf: aDeviceClass ]
]

{ #category : #accessing }
PtyWorkplace >> devices [
	^ devices
]

{ #category : #accessing }
PtyWorkplace >> devices: anObject [
	devices := anObject
]

{ #category : #controlling }
PtyWorkplace >> endWorkSessionFor: aWorkflow [
	announcer announce: (PtyWorkSessionEnded workSession: aWorkflow endSession)
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
	"Here it should be a call to workplace settings"
	^requestedTask
]

{ #category : #initialization }
PtyWorkplace >> initialize [
	super initialize.
	
	announcer := Announcer new.
	settings := PtySettings new.
	devices := OrderedCollection new. 
	defaultTaskExecutionPriority := Processor userBackgroundPriority.
	currentWorkflow := PtyWorkflow new
]

{ #category : #controlling }
PtyWorkplace >> open [
	devices do: [:each | each attachToWorkplace ]
]

{ #category : #'task execution' }
PtyWorkplace >> planExecutionOf: aTask [

	aTask user: user.
	aTask assignToActiveWorkflowIn: self. 
		
	^self findPreferredTaskImplementing: aTask
]

{ #category : #controlling }
PtyWorkplace >> removeAllTasks [
	currentWorkflow removeAllTasks
]

{ #category : #accessing }
PtyWorkplace >> settings [
	^ settings
]

{ #category : #accessing }
PtyWorkplace >> settings: anObject [
	settings := anObject
]

{ #category : #controlling }
PtyWorkplace >> unsubscribe: anObject [

	announcer unsubscribe: anObject
]

{ #category : #accessing }
PtyWorkplace >> user [
	^ user
]

{ #category : #accessing }
PtyWorkplace >> user: aUser [
	user := aUser.
	user workplace: self
]

{ #category : #controlling }
PtyWorkplace >> when: aWorkSessionEventClass send: aSelector to: anObject [

	announcer when: aWorkSessionEventClass send: aSelector to: anObject
]
