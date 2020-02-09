Class {
	#name : #PtyTask,
	#superclass : #Object,
	#instVars : [
		'user',
		'name',
		'announcer',
		'prototype',
		'context',
		'executionStrategy',
		'returnStrategy',
		'workflowActivationStrategy',
		'executionPriority',
		'parentTask',
		'initialWorkflow',
		'workflow',
		'continuation',
		'workplace'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTask class >> named: aString [
	^self new name: aString 
]

{ #category : #controlling }
PtyTask >> activateInitialWorkflow [

	workflow activateAs: initialWorkflow 
]

{ #category : #controlling }
PtyTask >> activationRequest [

	^PtyRunTaskRequest for: self
]

{ #category : #accessing }
PtyTask >> activationStrategy [
	^ executionStrategy
]

{ #category : #accessing }
PtyTask >> activationStrategy: anObject [
	executionStrategy := anObject
]

{ #category : #testing }
PtyTask >> allowChangeParentViewAreaState [
	^true
]

{ #category : #testing }
PtyTask >> allowSeparateItems [
	^true
]

{ #category : #accessing }
PtyTask >> announce: anAnnouncement [

	announcer announce: anAnnouncement.
	context ifNotNil: [self parent announce: anAnnouncement ]
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
PtyTask >> asNewApplication [
	^PtyRunApplicationTask on: self
]

{ #category : #converting }
PtyTask >> asTask [
	^self
]

{ #category : #converting }
PtyTask >> asUserAction [
	^PtyActivateTask task: self
]

{ #category : #accessing }
PtyTask >> basePrototypeContexts [
	^{PtyTaskPrototypeContext of: self}
]

{ #category : #controlling }
PtyTask >> beActiveInWorkflow [ 

	workflow registerNewTask: self
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

{ #category : #execution }
PtyTask >> body [
	self subclassResponsibility 
]

{ #category : #testing }
PtyTask >> canBePrototypeInContextOf: aTask [
	
	^(aTask isCreatedByCurrentRequestFrom: self) not
]

{ #category : #accessing }
PtyTask >> context [
	^context
]

{ #category : #accessing }
PtyTask >> context: aTaskContext [
	context := aTaskContext 
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
PtyTask >> copyAsNewInstance [
	^self veryDeepCopy 
]

{ #category : #copying }
PtyTask >> copyAsPrototype [

	^self veryDeepCopy 
]

{ #category : #controlling }
PtyTask >> createContextFor: anActivationStrategy [

	| newContext |
	newContext := PtyTaskContext of: self.
	newContext activation: anActivationStrategy.
	^newContext
]

{ #category : #controlling }
PtyTask >> currentExecutionStageStartedWith: initialExecutionStage [

	^Continuation currentDo: [ :cc | 
		continuation := cc.	
		initialExecutionStage ]
]

{ #category : #accessing }
PtyTask >> currentWorker [
	^workplace findWorkerExecutingCurrentTask
]

{ #category : #accessing }
PtyTask >> defaultActivationStrategy [

	^PtyInheritedActivationStrategy new 
		shouldRestoreParentArea: self shouldRestoreParentArea;
		allowSeparateItems: self allowSeparateItems;
		yourself 
]

{ #category : #accessing }
PtyTask >> defaultExecutionPriority [
	^ workplace defaultTaskExecutionPriority
]

{ #category : #'initialize-release' }
PtyTask >> defaultExecutionStrategy [
	^PtyImmediateExecutionStrategy new
]

{ #category : #accessing }
PtyTask >> defaultPrototypeContextName [
	^self class name
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
	
	self currentWorker deliverResult: anObject of: self
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
PtyTask >> findCommonParentWith: aTask [

	| commonParent |
	context ifNil: [^nil].
	aTask context ifNil: [^nil].
	
	commonParent := aTask context taskCallChain detect: [:each | each == self parent] ifNone: [nil].
	commonParent ifNotNil: [^commonParent].
	
	^self parent findCommonParentWith: aTask 
		
]

{ #category : #accessing }
PtyTask >> guide [
	^ workplace
]

{ #category : #accessing }
PtyTask >> guide: anObject [
	workplace := anObject
]

{ #category : #testing }
PtyTask >> hasParentSuchThat: aBlock [

	context ifNil: [^false].
	
	(aBlock value: self parent) ifTrue: [^true].
	
	^self parent hasParentSuchThat: aBlock 
]

{ #category : #testing }
PtyTask >> hasPrototype [

	^prototype notNil 
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
]

{ #category : #testing }
PtyTask >> isChildrenShouldRestoreParentArea [

	executionStrategy shouldRestoreParentArea ifFalse: [^false].
	
	context ifNil: [^true].
	
	context shouldRestoreParentArea ifTrue: [^true].
	
	^self parent isChildrenShouldRestoreParentArea
]

{ #category : #testing }
PtyTask >> isCreatedByCurrentRequest [

	^workplace isCurrentRequestIncludesTask: self
]

{ #category : #testing }
PtyTask >> isCreatedByCurrentRequestFrom: aTask [ 

	| parentTask |
	context ifNil: [^false].
	
	parentTask := context task.
	
	parentTask isCreatedByCurrentRequest ifFalse: [^false].
	
	(parentTask isSimilarTo: aTask) ifTrue: [^true].
	
	^parentTask isCreatedByCurrentRequestFrom: aTask
	
]

{ #category : #testing }
PtyTask >> isInitialTask [
	^parentTask isNil
]

{ #category : #testing }
PtyTask >> isKindOfTask: aTask [ 
	(self isKindOf: aTask class) ifFalse: [^false].
	
	^name = aTask name
]

{ #category : #testing }
PtyTask >> isSimilarTo: aTask [ 
	self class == aTask class ifFalse: [^false].
	
	^name = aTask name
]

{ #category : #controlling }
PtyTask >> jumpToExecutionStage: aTaskExecutionStage [ 
	
	continuation value: aTaskExecutionStage 
]

{ #category : #controlling }
PtyTask >> jumpToResultDeliveryStageWith: resultObject [ 
	
	self jumpToExecutionStage: (PtyTaskResultDeliveryStage of: self withResult: resultObject)
]

{ #category : #controlling }
PtyTask >> jumpToRetryStage [
	
	self jumpToExecutionStage: (PtyTaskRetryStage of: self)
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
PtyTask >> parent [
	context ifNil: [^nil].
	
	^ context task
]

{ #category : #accessing }
PtyTask >> parentLike: taskClass [

	(self parent isKindOf: taskClass) ifTrue: [^self parent].
	
	^self parent parentLike: taskClass 
]

{ #category : #accessing }
PtyTask >> parentTask [
	^ parentTask
]

{ #category : #accessing }
PtyTask >> parentTask: aTask [
	parentTask := aTask.
	workflow := aTask workflow
]

{ #category : #controlling }
PtyTask >> performExtraRequestBy: aGuide [

	aGuide requestUserFor: (PtyAddExtraTask on: self)
]

{ #category : #'morphic menu' }
PtyTask >> populateSettingsMenu: aMenu for: aPrototype [ 

	| activations subMenu |
	activations := PtyTaskActivationStrategy2 allSubclasses copyWithout: executionStrategy class.
	activations ifEmpty: [ ^ self ].
	
	subMenu := MenuMorph new defaultTarget: self.
	activations
		do: [ :each | 
			subMenu
				add: each name
				target: (aPrototype proxyForSample: self)
				selector: #useTaskActivationOf:
				argumentList: {each} ].
	aMenu add: 'replace ' , executionStrategy class name , ' with:' subMenu: subMenu.
	
	executionStrategy populateSettingsMenu: aMenu for: aPrototype
]

{ #category : #controlling }
PtyTask >> prepareActivationBy: aGuide [

	| newActivation |
	workplace := aGuide.
	user := aGuide user.
	context := aGuide context.
	
	newActivation := executionStrategy createCopy.
	newActivation 
		guide: aGuide;
		parent: context activation.
	newActivation prepareForEscapeTo: self fromContext: context.
	
	^newActivation.
]

{ #category : #controlling }
PtyTask >> prepareExecutionWorkflow [

	workflowActivationStrategy prepareWorkflow: workflow forExecutionOf: self
]

{ #category : #controlling }
PtyTask >> prepareReturnWorkflow [

	returnStrategy prepareWorkflow: workflow forReturnFrom: self
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

{ #category : #accessing }
PtyTask >> prototype [
	^ prototype
]

{ #category : #accessing }
PtyTask >> prototype: anObject [
	prototype := anObject
]

{ #category : #accessing }
PtyTask >> prototypeContextName [
	^name ifNil: [self defaultPrototypeContextName]
]

{ #category : #converting }
PtyTask >> readFromSample: aTask [
	
	self class allInstVarNames do: [:each | 
		(self instVarNamed: each) ifNil: [ | i |
			i := aTask class instVarIndexFor: each ifAbsent: [nil].
			i ifNotNil: [
				self instVarNamed: each put: (aTask instVarAt: i)]
		]
			
	]
]

{ #category : #accessing }
PtyTask >> readSampleProperitiesFrom: someRequestedTask [
	super readSampleProperitiesFrom: someRequestedTask.
	
	name := someRequestedTask name
]

{ #category : #execution }
PtyTask >> requestExecution [ 

	initialWorkflow := workflow captureStateForNewTask.
	
	^executionStrategy requestExecutionOf: self using: self currentWorker
]

{ #category : #execution }
PtyTask >> retryExecution [

	continuation ifNil: [ ^self error: 'No continuation for retry!' ].
	
	self currentWorker retryTask: self
]

{ #category : #accessing }
PtyTask >> returnStrategy [
	^ returnStrategy
]

{ #category : #accessing }
PtyTask >> returnStrategy: anObject [
	returnStrategy := anObject
]

{ #category : #testing }
PtyTask >> shouldRestoreParentArea [ 
	^true
]

{ #category : #testing }
PtyTask >> shouldSeparateForkTasks [
	^false
]

{ #category : #controlling }
PtyTask >> spawnWorkflow [ 
	"Task belongs to its workflow. It keeps the state of this workflow at the time when the task was requested. The initialWorkflow variable represents this initial state.
	When task is spawned it must ensure this logic. So the initialWorkflow must represent the initial state of this new spawned workflow"
	workflow := workflow spawnNew.
	initialWorkflow := workflow captureStateForNewTask
]

{ #category : #execution }
PtyTask >> startExecution [ 
	
	| result |
	self prepareExecutionWorkflow.
	result := self body.
	self prepareReturnWorkflow.
	^result
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
PtyTask >> useTaskActivationOf: aTaskActivationStrategyClass [

	self activationStrategy: aTaskActivationStrategyClass new.
	
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

{ #category : #accessing }
PtyTask >> workplace [
	^ workplace
]

{ #category : #accessing }
PtyTask >> workplace: anObject [
	workplace := anObject
]
