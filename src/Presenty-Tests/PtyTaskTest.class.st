Class {
	#name : #PtyTaskTest,
	#superclass : #TestCase,
	#instVars : [
		'task',
		'workflow',
		'initialWorkflow'
	],
	#category : #'Presenty-Tests'
}

{ #category : #running }
PtyTaskTest >> setUp [
	super setUp.
	
	initialWorkflow := Mock new.
	workflow := Mock new.
	task := [  ] asTaskNamed: 'Test task'.
	task workflow: workflow.
	task initialWorkflow: initialWorkflow
]

{ #category : #tests }
PtyTaskTest >> testAssignToActiveWorkflow [

	| workplace |
	workplace := Mock new.
	
	task assignToActiveWorkflowIn: workplace.
	
	task workflow should beReturnedFrom: [ workplace findActiveWorkflowOrCreateNewOne ].
	task parentTask should beReturnedFrom: [ task workflow activeTask ]
]

{ #category : #tests }
PtyTaskTest >> testBeActiveInWorkflow [
	
	task beActiveInWorkflow.
	
	workflow should receive registerNewTask: task
]

{ #category : #tests }
PtyTaskTest >> testBeActiveShouldFirstActivateSpawningParentTask [

	| spawningTask |
	spawningTask := Mock new.
	task stub spawningParentTask willReturn: spawningTask.
	(workflow stub includesTask: task) willReturn: false.
	
	task beActive.
	
	[spawningTask beActive.
	workflow activateAs: initialWorkflow] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testBeActiveWhenItIsAlreadyActiveInWorkflow [

	(workflow stub includesTask: task) willReturn: true.
	
	task beActive.
	
	workflow should not receive activateAs: initialWorkflow
]

{ #category : #tests }
PtyTaskTest >> testBeActiveWhenItIsNotActiveInWorkflow [

	(workflow stub includesTask: task) willReturn: false.
	
	task beActive.
	
	[workflow activateAs: initialWorkflow.
	workflow registerNewTask: task] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testBeDefferedTask [

	task beDeferred.

	task executionStrategy should beInstanceOf: PtyDeferredExecutionStrategy
]

{ #category : #tests }
PtyTaskTest >> testBeImmediateTask [

	task beImmediate.

	task executionStrategy should beInstanceOf: PtyImmediateExecutionStrategy
]

{ #category : #tests }
PtyTaskTest >> testBeOneShotTask [

	task beOneShot.

	task returnStrategy should beInstanceOf: PtyOneShotTaskReturnStrategy
]

{ #category : #tests }
PtyTaskTest >> testBePermanentTask [

	task bePermanent.

	task returnStrategy should beInstanceOf: PtyPermanentTaskReturnStrategy
]

{ #category : #tests }
PtyTaskTest >> testBelongsToWorkflow [

	task workflow: #workflow.
	
	task should be belongsToWorkflow: #workflow.
	task should not be belongsToWorkflow: #anotherWorkflow
]

{ #category : #tests }
PtyTaskTest >> testConvertingToTask [
	
	task asTask should be: task
]

{ #category : #tests }
PtyTaskTest >> testCreationFromBlock [

	task := [ #done ] asTask.
	
	task should beInstanceOf: PtyPluggableTask.
	task blockBody value should be: #done
]

{ #category : #tests }
PtyTaskTest >> testCreationFromBlockWithName [

	task := [ #done ] asTaskNamed: #testTask.
	
	task should beInstanceOf: PtyPluggableTask.
	task blockBody value should be: #done.
	task name should be: #testTask
]

{ #category : #tests }
PtyTaskTest >> testCurrentWorkflowStage [

	| stage |
	stage := task currentWorkflowStageStartedWith: #taskStartStage.

	stage should be: #taskStartStage
]

{ #category : #tests }
PtyTaskTest >> testCurrentWorkflowStageShouldKeepActualContinuationInTask [

	| stage |
	stage := task currentWorkflowStageStartedWith: #taskStartStage.

	stage = #taskStartStage ifTrue: [ 
		task continuation value: #stageFromContinuation].
	
	stage should be: #stageFromContinuation
]

{ #category : #tests }
PtyTaskTest >> testDefaultExecutionPriorityIsReturnedFromWorkplace [

	| workflow |
	workflow := Mock new.
	task workflow: workflow.
	
	task executionPriority should beReturnedFrom: [ workflow defaultTaskExecutionPriority ]
]

{ #category : #tests }
PtyTaskTest >> testDeliveringResult [

	| workflow |
	workflow := Mock new.
	task workflow: workflow.
	task continuation: #continuation.
		
	task deliverResult: #taskResult.

	workflow should receive deliverResult: #taskResult of: task
]

{ #category : #tests }
PtyTaskTest >> testDeliveringResultWhenTaskWasNotStarted [

	| workflow error |
	workflow := Mock new.
	task workflow: workflow.
	task continuation: nil.
		
	error := [task deliverResult: #taskResult] should fail.
	error where description should includeSubstring: 'No continuation'
]

{ #category : #tests }
PtyTaskTest >> testExecutionShouldPassThrough3Steps [
	
	task workflow: Mock new.
	task stub.
	
	task startExecution.

	[task prepareExecutionWorkflow.
	task body.
	task prepareReturnWorkflow] should beDoneInOrder 
]

{ #category : #tests }
PtyTaskTest >> testExecutionShouldReturnResultOfBody [

	| result |
	task := [ #done ] asTask.
	task executionStrategy: Mock new.
	task workflow: Mock new.
	
	result := task startExecution.

	result should be: #done
]

{ #category : #tests }
PtyTaskTest >> testHasDefaultExecutionStrategy [

	task executionStrategy class should equal: task defaultExecutionStrategy class
]

{ #category : #tests }
PtyTaskTest >> testHasDefaultReturnStrategy [

	task returnStrategy class should equal: task defaultReturnStrategy class
]

{ #category : #tests }
PtyTaskTest >> testHasDefaultWorkflowActivationStrategy [

	task workflowActivationStrategy class should equal: task defaultWorkflowActivationStrategy class
]

{ #category : #tests }
PtyTaskTest >> testInitialWorkflowActivation [

	| spawningTask |
	spawningTask := Mock new.
	task stub spawningParentTask willReturn: spawningTask.

	task activateInitialWorkflow.
	
	[spawningTask beActive.
	workflow activateAs: initialWorkflow] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testInitialWorkflowActivationWhenItIsInitialTask [

	task should be isInitialTask.
	
	task activateInitialWorkflow.
	
	workflow should receive activateAs: initialWorkflow

	
]

{ #category : #tests }
PtyTaskTest >> testIsImmediateByDefault [

	task executionStrategy should beInstanceOf: PtyImmediateExecutionStrategy 
]

{ #category : #tests }
PtyTaskTest >> testIsInitialTask [

	task := PtyTask new.
	
	task should be isInitialTask.
	
	task parentTask: Mock new.
	
	task should not be isInitialTask.
]

{ #category : #tests }
PtyTaskTest >> testIsOneShotByDefault [

	task returnStrategy should beInstanceOf: PtyOneShotTaskReturnStrategy 
]

{ #category : #tests }
PtyTaskTest >> testIsSpawnedTask [
	| parentTask |
	task should not be isSpawnedTask.
	
	parentTask := Mock new.
	task parentTask: parentTask.
	task workflow: #workflow.
	
	(parentTask stub belongsToWorkflow: #workflow) willReturn: true.
	task should not be isSpawnedTask.
	
	(parentTask stub belongsToWorkflow: #workflow) willReturn: false.
	task should be isSpawnedTask.
]

{ #category : #tests }
PtyTaskTest >> testJumpToWorkflowStage [

	| continuation |
	continuation := Mock new.
	task continuation: continuation.
	
	task jumpToWorkflowStage: #executionStage.

	continuation should receiver value: #executionStage
]

{ #category : #tests }
PtyTaskTest >> testPrepareExecutionWorkflow [
	
	| workflowActivationStrategy |
	workflowActivationStrategy := Mock new.
	task workflowActivationStrategy: workflowActivationStrategy.
	task workflow: #workflow.
		
	task prepareExecutionWorkflow.

	workflowActivationStrategy should receive prepareWorkflow: #workflow forExecutionOf: task
]

{ #category : #tests }
PtyTaskTest >> testPrepareReturnWorkflow [
	
	| returnStrategy |
	returnStrategy := Mock new.
	task returnStrategy: returnStrategy.
	task workflow: #workflow.
		
	task prepareReturnWorkflow.

	returnStrategy should receive prepareWorkflow: #workflow forReturnFrom: task
]

{ #category : #tests }
PtyTaskTest >> testRequestExecution [

	| executionStrategy result workflow |
	executionStrategy := Mock new.
	workflow := Mock new.
	task workflow: workflow; executionStrategy: executionStrategy.

	result := task requestExecution.

	result should beReturnedFrom: [ executionStrategy requestExecutionOf: task in: workflow]
]

{ #category : #tests }
PtyTaskTest >> testRequestExecutionShouldCaptureInitialWorkflow [
	| executionStrategy |
	executionStrategy := Mock new.
	task executionStrategy: executionStrategy.

	task requestExecution.

	task initialWorkflow should beReturnedFrom: [ workflow captureStateForNewTask ].
	[ workflow captureStateForNewTask.
	executionStrategy requestExecutionOf: Any in: Any ] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testRetryExecution [

	| workflow |
	workflow := Mock new.
	task workflow: workflow.
	task continuation: #continuation.
		
	task retryExecution.

	workflow should receive retryTask: task
]

{ #category : #tests }
PtyTaskTest >> testRetryExecutionWhenTaskWasNotStarted [

	| workflow error |
	workflow := Mock new.
	task workflow: workflow.
	task continuation: nil.
		
	error := [task retryExecution] should fail.
	error where description should includeSubstring: 'No continuation'
]

{ #category : #tests }
PtyTaskTest >> testSpawningParentTaskIsNilForInitialTask [

	task should be isInitialTask.
	
	task spawningParentTask should be: nil
]

{ #category : #tests }
PtyTaskTest >> testSpawningParentTaskIsParentSpawningTaskWhenTaskWasNotSpawned [

	| parentTask |
	parentTask := Mock new.
	task parentTask: parentTask.
	
	task stub isSpawnedTask willReturn: false.
	
	task spawningParentTask should beReturnedFrom: [ parentTask spawningParentTask ]
]

{ #category : #tests }
PtyTaskTest >> testSpawningParentTaskIsParentWhenTaskWasSpawned [

	task parentTask: #parentTask.
	
	task stub isSpawnedTask willReturn: true.
	
	task spawningParentTask should be: #parentTask
]

{ #category : #tests }
PtyTaskTest >> testSpawningWorkflow [

	| newWorkflow |
	newWorkflow := Mock new.
	workflow stub spawnNew willReturn: newWorkflow.
	
	task spawnWorkflow.
	
	task workflow should be: newWorkflow.
	task initialWorkflow should beReturnedFrom: [newWorkflow captureStateForNewTask].
]

{ #category : #tests }
PtyTaskTest >> testUseCleanWorkflow [

	task useCleanWorkflow.

	task workflowActivationStrategy should beInstanceOf: PtyCleanWorkflowStrategy 
]

{ #category : #tests }
PtyTaskTest >> testUseInheritedWorkflow [

	task useInheritedWorkflow.

	task workflowActivationStrategy should beInstanceOf: PtyInheritWorkflowStrategy 
]

{ #category : #tests }
PtyTaskTest >> testUseSeparateWorkflow [

	| currentExecutionStrategy |
	currentExecutionStrategy := task executionStrategy.
	
	task useSeparateWorkflow.

	task executionStrategy should beInstanceOf: PtySeparateWorkflowExecutionStrategy.
	task executionStrategy actualWorkflowExecutionStrategy should be: currentExecutionStrategy
]

{ #category : #tests }
PtyTaskTest >> testUsesInheritedWorkflowByDefault [

	task workflowActivationStrategy should beInstanceOf: PtyInheritWorkflowStrategy 
]