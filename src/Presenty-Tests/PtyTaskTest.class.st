Class {
	#name : #PtyTaskTest,
	#superclass : #TestCase,
	#instVars : [
		'task',
		'workflow',
		'initialWorkflow'
	],
	#category : #'Presenty-Tests-Tasks'
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
PtyTaskTest >> testAddTool [
	
	task addTool: #tool.
	
	task tools should include: #tool
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
PtyTaskTest >> testAttachToolsToPanel [
	
	| tool1 tool2 |
	tool1 := Mock new. tool2 := Mock new.	
	task tools: {tool1. tool2}.
	
	task attachToolsToPanel.
	
	tool1 should receive attachToPanel.
	tool2 should receive attachToPanel
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

	task should be belongsToWorkflow: workflow.
	task should not be belongsToWorkflow: #anotherWorkflow
]

{ #category : #tests }
PtyTaskTest >> testControlPanel [
	
	| panel anotherTool actual |
	panel := PtyPanel new.
	anotherTool := Mock new.
	task tools: {anotherTool. panel}.
	task stub isEnabled willReturn: true.
	
	actual := task controlPanel.
	
	actual should be: panel
]

{ #category : #tests }
PtyTaskTest >> testControlPanelIsCreatedForRootTask [
	
	| panel |
	task stub isEnabled willReturn: true.
	task tools removeAll.
	
	panel := task controlPanel.
	
	task tools should include: panel
]

{ #category : #tests }
PtyTaskTest >> testControlPanelIsInheritedFromParentWhenOwnPanelIsAbsent [
	
	| panel parent |
	task tools removeAll.
	parent := Mock new.
	task parentTask: parent.
	task stub isEnabled willReturn: true.
	
	panel := task controlPanel.
	
	panel should beReturnedFrom: [ parent controlPanel ].
	task tools should be isEmpty
]

{ #category : #tests }
PtyTaskTest >> testControlPanelIsInheritedFromParentWhenTaskIsDisabled [
	
	| panel parent ownPanel |
	ownPanel := PtyPanel new.
	task tools: {ownPanel}.
	parent := Mock new.
	task parentTask: parent.
	task stub isEnabled willReturn: false.
	
	panel := task controlPanel.
	
	panel should beReturnedFrom: [ parent controlPanel ].
	task tools should equal: { ownPanel }
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

	task executionPriority should beReturnedFrom: [ workflow defaultTaskExecutionPriority ]
]

{ #category : #tests }
PtyTaskTest >> testDeliveringResult [

	task continuation: #continuation.
		
	task deliverResult: #taskResult.

	workflow should receive deliverResult: #taskResult of: task
]

{ #category : #tests }
PtyTaskTest >> testDeliveringResultWhenTaskWasNotStarted [

	| error |
	task continuation: nil.
		
	error := [task deliverResult: #taskResult] should fail.
	error where description should includeSubstring: 'No continuation'
]

{ #category : #tests }
PtyTaskTest >> testExecutionShouldPassThrough3Steps [
	
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
PtyTaskTest >> testHasEmptyToolsByDefault [
	
	task tools should be isEmpty
]

{ #category : #tests }
PtyTaskTest >> testIsEnabled [
	
	| actual |
	actual := task isEnabled.
	
	actual should beReturnedFrom: [ workflow includesTask: task ]
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
		
	task prepareExecutionWorkflow.

	workflowActivationStrategy should receive prepareWorkflow: workflow forExecutionOf: task
]

{ #category : #tests }
PtyTaskTest >> testPrepareReturnWorkflow [
	
	| returnStrategy |
	returnStrategy := Mock new.
	workflow := Mock new.
	task returnStrategy: returnStrategy.
	task workflow: workflow.
		
	task prepareReturnWorkflow.

	[returnStrategy prepareReturnFrom: task.
	workflow disableIfEmpty] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testRequestExecution [

	| executionStrategy result |
	executionStrategy := Mock new.
	task executionStrategy: executionStrategy.

	result := task requestExecution.

	result should beReturnedFrom: [ executionStrategy requestExecutionOf: task in: workflow]
]

{ #category : #tests }
PtyTaskTest >> testRequestExecutionShouldCaptureInitialWorkflow [
	| executionStrategy |
	executionStrategy := Mock new.
	task executionStrategy: executionStrategy.

	task requestExecution.

	task initialWorkflow should beReturnedFrom: [ workflow captureState ].
	[ workflow captureState.
	executionStrategy requestExecutionOf: Any in: Any ] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testResumingInitialWorkflow [

	| spawningTask |
	spawningTask := Mock new.
	task stub spawningParentTask willReturn: spawningTask.

	task resumeInitialWorkflow.
	
	[spawningTask resumeWorkflow.
	workflow resumeWorkflow: initialWorkflow] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testResumingInitialWorkflowOfInitialTask [

	task should be isInitialTask.
	
	task resumeInitialWorkflow.
	
	workflow should receive resumeWorkflow: initialWorkflow

	
]

{ #category : #tests }
PtyTaskTest >> testResumingWorkflowShouldAddTaskIntoIt [

	(workflow stub includesTask: task) willReturn: false.
	
	task resumeWorkflow.
	
	[workflow resumeWorkflow: initialWorkflow.
	workflow registerNewTask: task] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testResumingWorkflowShouldFirstResumeSpawningParentTask [

	| spawningTask |
	spawningTask := Mock new.
	task stub spawningParentTask willReturn: spawningTask.
	(workflow stub includesTask: task) willReturn: false.
	
	task resumeWorkflow.
	
	[spawningTask resumeWorkflow.
	workflow resumeWorkflow: initialWorkflow] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testResumingWorkflowWhichAlreadyIncludesTask [

	(workflow stub includesTask: task) willReturn: true.
	
	task resumeWorkflow.
	
	workflow should not receive resumeWorkflow: initialWorkflow
]

{ #category : #tests }
PtyTaskTest >> testRetryExecution [

	task continuation: #continuation.
		
	task retryExecution.

	workflow should receive retryTask: task
]

{ #category : #tests }
PtyTaskTest >> testRetryExecutionWhenTaskWasNotStarted [

	| error |
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
	task initialWorkflow should beReturnedFrom: [newWorkflow captureState].
]

{ #category : #tests }
PtyTaskTest >> testStartingNewSession [

	task startNewSession.

	task workSession should beReturnedFrom: [ workflow startNewSession ].
]

{ #category : #tests }
PtyTaskTest >> testStopExecution [
		
	task stopExecution.

	workflow should receive stopTask: task
]

{ #category : #tests }
PtyTaskTest >> testStopWorkSession [

	| session |
	session := Mock new.
	task workSession: session.

	task stopWorkSession.

	session should receive stopWorkflow: workflow
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
