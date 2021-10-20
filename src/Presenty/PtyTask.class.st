Class {
	#name : #PtyTask,
	#superclass : #Object,
	#instVars : [
		'user',
		'name',
		'announcer',
		'executionStrategy',
		'returnStrategy',
		'workflowActivationStrategy',
		'executionPriority',
		'parentTask',
		'initialWorkflow',
		'workflow',
		'continuation',
		'tools',
		'workSession'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #testing }
PtyTask class >> isAbstract [ 
	^self = PtyTask 
]

{ #category : #'instance creation' }
PtyTask class >> named: aString [
	^self new name: aString 
]

{ #category : #accessing }
PtyTask >> addTool: aTool [ 
	aTool targetTask: self.
	tools add: aTool
]

{ #category : #accessing }
PtyTask >> announcer [
	^ announcer
]

{ #category : #accessing }
PtyTask >> announcer: anObject [
	announcer := anObject
]

{ #category : #converting }
PtyTask >> asTask [
	^self
]

{ #category : #controlling }
PtyTask >> assignToActiveWorkflowIn: aWorkplace [
	workflow := aWorkplace findActiveWorkflowOrCreateNewOne.
	parentTask := workflow activeTask
]

{ #category : #controlling }
PtyTask >> attachToolsToPanel [

	tools do: [ :each | each attachToPanel ]
]

{ #category : #'initialize-release' }
PtyTask >> beDeferred [

	executionStrategy := PtyDeferredExecutionStrategy new
]

{ #category : #'initialize-release' }
PtyTask >> beImmediate [

	executionStrategy := PtyImmediateExecutionStrategy new
]

{ #category : #'initialize-release' }
PtyTask >> beOneShot [

	returnStrategy := PtyOneShotTaskReturnStrategy new
]

{ #category : #'initialize-release' }
PtyTask >> bePermanent [

	returnStrategy := PtyPermanentTaskReturnStrategy new
]

{ #category : #testing }
PtyTask >> belongsToWorkflow: aWorkflow [
	^workflow = aWorkflow
]

{ #category : #execution }
PtyTask >> body [
	self subclassResponsibility 
]

{ #category : #accessing }
PtyTask >> continuation [
	^ continuation
]

{ #category : #accessing }
PtyTask >> continuation: anObject [
	continuation := anObject
]

{ #category : #accessing }
PtyTask >> controlPanel [

	| panel |
	self isEnabled ifFalse: [ ^parentTask controlPanel].
	tools detect: [:each | each isPanel ] ifFound: [:found | ^found ].
	parentTask ifNotNil: [ ^parentTask controlPanel ].
	
	panel := PtyPanel new.
	self addTool: panel.
	^panel
]

{ #category : #controlling }
PtyTask >> currentWorkflowStageStartedWith: aTaskStartStage [

	^Continuation currentDo: [ :cc | 
		continuation := cc.	
		aTaskStartStage ]
]

{ #category : #accessing }
PtyTask >> defaultExecutionPriority [
	^workflow defaultTaskExecutionPriority
]

{ #category : #'initialize-release' }
PtyTask >> defaultExecutionStrategy [
	^PtyImmediateExecutionStrategy new
]

{ #category : #'initialize-release' }
PtyTask >> defaultReturnStrategy [
	^PtyOneShotTaskReturnStrategy new
]

{ #category : #'initialize-release' }
PtyTask >> defaultWorkflowActivationStrategy [
	^PtyInheritWorkflowStrategy new
]

{ #category : #execution }
PtyTask >> deliverResult: anObject [

	continuation ifNil: [ ^self error: 'No continuation for return!' ].
	
	workflow deliverResult: anObject of: self
]

{ #category : #controlling }
PtyTask >> detachToolsFromPanel [

	tools do: [ :each | each detachFromPanel ]
]

{ #category : #accessing }
PtyTask >> executionPriority [
	^ executionPriority ifNil: [ self defaultExecutionPriority ]
]

{ #category : #accessing }
PtyTask >> executionPriority: anObject [
	executionPriority := anObject
]

{ #category : #accessing }
PtyTask >> executionStrategy [
	^ executionStrategy
]

{ #category : #accessing }
PtyTask >> executionStrategy: aTaskExecutionStrategy [
	executionStrategy := aTaskExecutionStrategy
]

{ #category : #accessing }
PtyTask >> initialWorkflow [
	^ initialWorkflow
]

{ #category : #accessing }
PtyTask >> initialWorkflow: anObject [
	initialWorkflow := anObject
]

{ #category : #'initialize-release' }
PtyTask >> initialize [ 
	super initialize.
	
	announcer := Announcer new.
	executionStrategy := self defaultExecutionStrategy.
	returnStrategy := self defaultReturnStrategy.
	workflowActivationStrategy := self defaultWorkflowActivationStrategy.
	tools := OrderedCollection new
]

{ #category : #testing }
PtyTask >> isEnabled [
	^workflow includesTask: self
]

{ #category : #testing }
PtyTask >> isInitialTask [
	^parentTask isNil
]

{ #category : #testing }
PtyTask >> isSpawnedTask [
	^self isInitialTask not and: [ (parentTask belongsToWorkflow: workflow) not ]
]

{ #category : #controlling }
PtyTask >> jumpToWorkflowStage: aWorkflowContinuationStage [ 
	
	continuation value: aWorkflowContinuationStage 
]

{ #category : #accessing }
PtyTask >> name [
	^ name
]

{ #category : #accessing }
PtyTask >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PtyTask >> parentTask [
	^ parentTask
]

{ #category : #accessing }
PtyTask >> parentTask: aTask [
	parentTask := aTask
]

{ #category : #controlling }
PtyTask >> prepareExecutionWorkflow [

	workflowActivationStrategy prepareWorkflow: workflow forExecutionOf: self
]

{ #category : #controlling }
PtyTask >> prepareReturnWorkflow [

	returnStrategy prepareReturnFrom: self.
	workflow disableIfEmpty
]

{ #category : #printing }
PtyTask >> printDetailsOn: aStream [

	name ifNil: [^self].
	
	aStream 
		nextPut: $(;
		nextPutAll: name;
		nextPut: $)
	
]

{ #category : #printing }
PtyTask >> printOn: aStream [

	super printOn: aStream.
	
	self printDetailsOn: aStream
]

{ #category : #execution }
PtyTask >> requestExecution [ 

	initialWorkflow := workflow captureState.
	
	^executionStrategy requestExecutionOf: self in: workflow
]

{ #category : #controlling }
PtyTask >> resumeInitialWorkflow [

	self spawningParentTask ifNotNil: [:spawningTask | spawningTask resumeWorkflow ].
	workflow resumeWorkflow: initialWorkflow.
	
]

{ #category : #controlling }
PtyTask >> resumeWorkflow [

	self spawningParentTask ifNotNil: [:spawningTask | spawningTask resumeWorkflow ].
	self isEnabled ifTrue: [ ^self ].
	
	workflow resumeWorkflow: initialWorkflow.
	workflow registerNewTask: self
	
]

{ #category : #execution }
PtyTask >> retryExecution [

	continuation ifNil: [ ^self error: 'No continuation for retry!' ].
	
	workflow retryTask: self
]

{ #category : #accessing }
PtyTask >> returnStrategy [
	^ returnStrategy
]

{ #category : #accessing }
PtyTask >> returnStrategy: anObject [
	returnStrategy := anObject
]

{ #category : #accessing }
PtyTask >> settings [
	^workflow settings
]

{ #category : #controlling }
PtyTask >> spawnWorkflow [ 
	"Task belongs to its workflow. It keeps the state of this workflow at the time when the task was requested. The initialWorkflow variable represents this initial state.
	When task is spawned it must ensure this logic. So the initialWorkflow must represent the initial state of this new spawned workflow"
	workflow := workflow spawnNew.
	initialWorkflow := workflow captureState
]

{ #category : #accessing }
PtyTask >> spawningParentTask [
	
	self isInitialTask ifTrue: [ ^nil ].
	self isSpawnedTask ifTrue: [ ^parentTask ].
	^parentTask spawningParentTask
]

{ #category : #execution }
PtyTask >> startExecution [ 
	
	| result |
	self prepareExecutionWorkflow.
	result := self body.
	self prepareReturnWorkflow.
	^result
]

{ #category : #controlling }
PtyTask >> startNewSession [ 
	workSession := workflow startNewSession
]

{ #category : #execution }
PtyTask >> stopExecution [
	
	workflow stopTask: self
]

{ #category : #execution }
PtyTask >> stopWorkSession [
	
	workSession stopWorkflow: workflow
]

{ #category : #accessing }
PtyTask >> tools [
	^ tools
]

{ #category : #accessing }
PtyTask >> tools: anObject [
	tools := anObject
]

{ #category : #'initialize-release' }
PtyTask >> useCleanWorkflow [

	workflowActivationStrategy := PtyCleanWorkflowStrategy new
]

{ #category : #'initialize-release' }
PtyTask >> useInheritedWorkflow [

	workflowActivationStrategy := PtyInheritWorkflowStrategy new
]

{ #category : #'initialize-release' }
PtyTask >> useSeparateWorkflow [

	executionStrategy := PtySeparateWorkflowExecutionStrategy using: executionStrategy 
]

{ #category : #accessing }
PtyTask >> user [
	^ user
]

{ #category : #accessing }
PtyTask >> user: anObject [
	user := anObject
]

{ #category : #accessing }
PtyTask >> workSession [
	^ workSession
]

{ #category : #accessing }
PtyTask >> workSession: anObject [
	workSession := anObject
]

{ #category : #accessing }
PtyTask >> workflow [
	^ workflow
]

{ #category : #accessing }
PtyTask >> workflow: anObject [
	workflow := anObject
]

{ #category : #accessing }
PtyTask >> workflowActivationStrategy [
	^ workflowActivationStrategy
]

{ #category : #accessing }
PtyTask >> workflowActivationStrategy: anObject [
	workflowActivationStrategy := anObject
]
