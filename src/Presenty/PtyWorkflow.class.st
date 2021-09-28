Class {
	#name : #PtyWorkflow,
	#superclass : #Object,
	#instVars : [
		'parentWorkflow',
		'currentTasks',
		'spawnedWorkflows',
		'worker',
		'currentSession'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #controlling }
PtyWorkflow >> activateControlPanel [

	spawnedWorkflows do: [ :each | each controlPanel activateOnPanel ]
]

{ #category : #accessing }
PtyWorkflow >> activeTask [ 
	^worker ifNotNil: [ worker activeTask ]
]

{ #category : #accessing }
PtyWorkflow >> allCurrentTasks [

	^currentTasks, (spawnedWorkflows flatCollect: [ :each | each allCurrentTasks ])
]

{ #category : #controlling }
PtyWorkflow >> captureState [
	^self copy
]

{ #category : #controlling }
PtyWorkflow >> cleanControlPanel [

	"currentTasks do: [ :each | each detachToolsFromPanel ]."
	currentTasks do: [ :each | each controlPanel removeAllTools ].
	spawnedWorkflows do: [ :each | each cleanControlPanel ]
]

{ #category : #accessing }
PtyWorkflow >> controlPanel [
	^currentTasks first controlPanel
]

{ #category : #accessing }
PtyWorkflow >> currentSession [
	^ currentSession
]

{ #category : #accessing }
PtyWorkflow >> currentSession: anObject [
	^ currentSession := anObject
]

{ #category : #accessing }
PtyWorkflow >> currentTasks [
	^ currentTasks
]

{ #category : #accessing }
PtyWorkflow >> currentTasks: anObject [
	currentTasks := anObject
]

{ #category : #accessing }
PtyWorkflow >> defaultTaskExecutionPriority [
	^worker defaultTaskExecutionPriority
]

{ #category : #controlling }
PtyWorkflow >> deferTask: aTask [

	currentTasks add: aTask.
	
	^worker executeWorkflowStage: (PtyTaskDefermentStage for: aTask)
]

{ #category : #controlling }
PtyWorkflow >> deliverResult: anObject of: aTask [
	
	worker executeWorkflowStage: (PtyTaskResultDeliveryStage for: aTask withResult: anObject)
]

{ #category : #controlling }
PtyWorkflow >> disable [
	parentWorkflow ifNotNil: [parentWorkflow removeSpawnedWorkflow: self]
]

{ #category : #controlling }
PtyWorkflow >> disableIfEmpty [
	
	self isEmpty ifTrue: [ self disable ]
]

{ #category : #controlling }
PtyWorkflow >> executeTask: aTask [
	aTask workSession: currentSession.
	
	^worker executeWorkflowStage: (PtyTaskStartStage for: aTask)
]

{ #category : #accessing }
PtyWorkflow >> findActiveWorkflowIfNone: noneBlock [
	| found |
	found := spawnedWorkflows detect: [ :each | each isActive ] ifNone: [ nil ].
	found ifNotNil: [ ^found ].

	spawnedWorkflows do: [ :each | 
		found := each findActiveWorkflowIfNone: [nil].
		found ifNotNil: [ ^found ]].
	
	^noneBlock value
]

{ #category : #testing }
PtyWorkflow >> includesTask: aTask [
	^currentTasks includes: aTask
]

{ #category : #initialization }
PtyWorkflow >> initialize [
	super initialize.
	
	currentTasks := OrderedCollection new.
	spawnedWorkflows := OrderedCollection new.
	self startNewSession
]

{ #category : #testing }
PtyWorkflow >> isActive [

	^worker isActive and: [ worker servesWorkflow: self ]
]

{ #category : #testing }
PtyWorkflow >> isEmpty [ 

	^currentTasks isEmpty and: [ 
		spawnedWorkflows allSatisfy: [ :each | each isEmpty ]]
]

{ #category : #testing }
PtyWorkflow >> isSpawnedFrom: aWorkflow [ 
	parentWorkflow ifNil: [ ^false ].
	
	^parentWorkflow = aWorkflow or: [ parentWorkflow isSpawnedFrom: aWorkflow ]
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
	
	currentTasks := currentTasks copy.
	spawnedWorkflows := spawnedWorkflows copy
]

{ #category : #controlling }
PtyWorkflow >> registerNewTask: aTask [
	currentTasks add: aTask
]

{ #category : #controlling }
PtyWorkflow >> removeAllTasks [

	currentTasks removeAll.
	spawnedWorkflows removeAll
]

{ #category : #controlling }
PtyWorkflow >> removeSpawnedWorkflow: aWorkflow [

	spawnedWorkflows remove: aWorkflow
]

{ #category : #controlling }
PtyWorkflow >> removeTask: aTask [ 
	currentTasks remove: aTask
]

{ #category : #controlling }
PtyWorkflow >> resumeSpawnedWorkflow: aSpawnedWorkflow [

	(spawnedWorkflows includes: aSpawnedWorkflow) ifFalse: [ 
		spawnedWorkflows add: aSpawnedWorkflow ].
	
	parentWorkflow ifNotNil: [ parentWorkflow resumeSpawnedWorkflow: self ]
]

{ #category : #controlling }
PtyWorkflow >> resumeWorkflow: aTemplateWorkflow [

	currentTasks := aTemplateWorkflow currentTasks copy.
	spawnedWorkflows := aTemplateWorkflow spawnedWorkflows copy.
	parentWorkflow notNil & (parentWorkflow ~= aTemplateWorkflow parentWorkflow) ifTrue: [ 
		parentWorkflow removeSpawnedWorkflow: self ].
	parentWorkflow := aTemplateWorkflow parentWorkflow.
	parentWorkflow ifNotNil: [ parentWorkflow resumeSpawnedWorkflow: self ]
]

{ #category : #controlling }
PtyWorkflow >> retryTask: aTask [
	
	worker executeWorkflowStage: (PtyTaskRetryStage for: aTask)
]

{ #category : #accessing }
PtyWorkflow >> settings [ 
	^worker settings
]

{ #category : #controlling }
PtyWorkflow >> spawnNew [
	| newWorkflow |
	newWorkflow := self class new.
	newWorkflow parentWorkflow: self.
	newWorkflow worker: worker.
	spawnedWorkflows add: newWorkflow.
	^newWorkflow
]

{ #category : #accessing }
PtyWorkflow >> spawnedWorkflows [
	^ spawnedWorkflows
]

{ #category : #accessing }
PtyWorkflow >> spawnedWorkflows: anObject [
	spawnedWorkflows := anObject
]

{ #category : #controlling }
PtyWorkflow >> startNewSession [
	^currentSession := PtyWorkSession for: self
]

{ #category : #controlling }
PtyWorkflow >> stopTask: aTask [
	
	worker executeWorkflowStage: (PtyTaskStopStage for: aTask)
]

{ #category : #controlling }
PtyWorkflow >> updateControlPanel [
	self cleanControlPanel.
	
	currentTasks do: [ :each | each attachToolsToPanel ].
	spawnedWorkflows do: [ :each | each updateControlPanel ]
]

{ #category : #accessing }
PtyWorkflow >> worker [
	^ worker
]

{ #category : #accessing }
PtyWorkflow >> worker: anObject [
	worker := anObject
]
