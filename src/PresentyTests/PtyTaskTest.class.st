Class {
	#name : #PtyTaskTest,
	#superclass : #TestCase,
	#instVars : [
		'task'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyTaskTest >> setUp [
	super setUp.
	
	task := [  ] asTaskNamed: 'Test task'
]

{ #category : #tests }
PtyTaskTest >> testBecomeDefferedTask [

	| executionStrategy |
	executionStrategy := task beDeferred.

	task executionStrategy should be: executionStrategy.
	executionStrategy should beInstanceOf: PtyDeferredTaskExecution
]

{ #category : #tests }
PtyTaskTest >> testBecomeImmediateTask [

	| executionStrategy |
	executionStrategy := task beImmediate.

	task executionStrategy should be: executionStrategy.
	executionStrategy should beInstanceOf: PtyImmediateTaskExecution
]

{ #category : #tests }
PtyTaskTest >> testBecomeOneShotTask [

	| executionStrategy |
	executionStrategy := task beOneShot.

	task executionStrategy should be: executionStrategy.
	executionStrategy should beInstanceOf: PtyOneShotTaskExecution
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
PtyTaskTest >> testCurrentExecutionStage [

	| continuation |
	continuation := task currentExecutionStage.

	continuation should beInstanceOf: PtyTaskStartStage.
	continuation task should be: task.
]

{ #category : #tests }
PtyTaskTest >> testCurrentExecutionStageShouldKeepActualContinuationInTask [

	| result |
	result := task currentExecutionStage.

	result class = PtyTaskStartStage ifTrue: [ 
		task continuation value: #resultFromContinuation].
	
	result should be: #resultFromContinuation
]

{ #category : #tests }
PtyTaskTest >> testDefaultExecutionPriorityIsReturnedFromWorkplace [

	| workplace |
	workplace := Mock new.
	task workplace: workplace.
	
	task executionPriority should beReturnedFrom: [ workplace defaultTaskExecutionPriority ]
]

{ #category : #tests }
PtyTaskTest >> testDeferExecutionShouldJustRegisterItInWorkplace [

	| workflow |
	workflow := Mock new.
	task workflow: workflow.
	
	task deferExecution.
	
	workflow should receive registerNewTask: task
]

{ #category : #tests }
PtyTaskTest >> testDeferExecutionShouldReturnFutureResult [

	| result |
	task workflow: Mock new.
	
	result := task deferExecution.
	
	result should beInstanceOf: PtyTaskExecutionFutureResult.
	result task should be: task
]

{ #category : #tests }
PtyTaskTest >> testDeliveringResult [

	| workplace worker |
	worker := Mock new.
	workplace := Mock new.
	task workplace: workplace.
	task continuation: #continuation.
	workplace stub findWorkerExecutingCurrentTask willReturn: worker.
		
	task deliverResult: #taskResult.

	worker should receive deliverResult: #taskResult of: task
]

{ #category : #tests }
PtyTaskTest >> testDeliveringResultWhenTaskWasNotStarted [

	| workplace error |
	workplace := Mock new.
	task workplace: workplace.
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
	
	result := task startExecution.

	result should be: #done
]

{ #category : #tests }
PtyTaskTest >> testHasDefaultExecutionStrategy [

	task executionStrategy class should equal: task defaultExecutionStrategy class
]

{ #category : #tests }
PtyTaskTest >> testInitialWorkflowActivation [

	| workflow |
	workflow := Mock new.
	task workflow: workflow.
	task initialWorkflow: #initialWorkflow.

	task activateInitialWorkflow.
	
	workflow should receive activateAs: #initialWorkflow

	
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

	task executionStrategy should beInstanceOf: PtyOneShotTaskExecution 
]

{ #category : #tests }
PtyTaskTest >> testJumpToExecutionStage [

	| continuation |
	continuation := Mock new.
	task continuation: continuation.
	
	task jumpToExecutionStage: #executionStage.

	continuation should receiver value: #executionStage
]

{ #category : #tests }
PtyTaskTest >> testJumpToResultDeliveryStage [

	| continuation |
	continuation := Mock new.
	task continuation: continuation.
	continuation stub value: Arg executionStage.
	
	task jumpToResultDeliveryStageWith: #taskResult.

	Arg executionStage should beInstanceOf: PtyTaskResultDeliveryStage.
	Arg executionStage where task should be: task.
	Arg executionStage where result should be: #taskResult.
]

{ #category : #tests }
PtyTaskTest >> testJumpToRetryStage [

	| continuation |
	continuation := Mock new.
	task continuation: continuation.
	continuation stub value: Arg executionStage.
	
	task jumpToRetryStage.

	Arg executionStage should beInstanceOf: PtyTaskRetryStage.
	Arg executionStage where task should be: task
]

{ #category : #tests }
PtyTaskTest >> testPrepareExecutionWorkflow [
	
	| executionStrategy |
	executionStrategy := Mock new.
	task executionStrategy: executionStrategy.
	task workflow: #workflow.
		
	task prepareExecutionWorkflow.

	executionStrategy should receive prepareWorkflow: #workflow forExecutionOf: task
]

{ #category : #tests }
PtyTaskTest >> testPrepareReturnWorkflow [
	
	| executionStrategy |
	executionStrategy := Mock new.
	task executionStrategy: executionStrategy.
	task workflow: #workflow.
		
	task prepareReturnWorkflow.

	executionStrategy should receive prepareWorkflow: #workflow forReturnFrom: task
]

{ #category : #tests }
PtyTaskTest >> testRequestExecution [

	| executionStrategy result workplace |
	executionStrategy := Mock new.
	workplace := Mock new.
	task workplace: workplace; workflow: Mock new; executionStrategy: executionStrategy.
	workplace stub findWorkerExecutingCurrentTask willReturn: #worker.

	result := task requestExecution.

	result should beReturnedFrom: [ executionStrategy requestExecutionOf: task using: #worker ]
]

{ #category : #tests }
PtyTaskTest >> testRequestExecutionShouldCaptureInitialWorkflow [
	| executionStrategy workflow workplace |
	executionStrategy := Mock new.
	workflow := Mock new.
	workplace := Mock new.
	task workflow: workflow; workplace: workplace; executionStrategy: executionStrategy.

	task requestExecution.

	task initialWorkflow should beReturnedFrom: [ workflow captureStateForNewTask ].
	[ workflow captureStateForNewTask.
	executionStrategy requestExecutionOf: Any using: Any ] should beDoneInOrder
]

{ #category : #tests }
PtyTaskTest >> testRetryExecution [

	| workplace worker |
	worker := Mock new.
	workplace := Mock new.
	task workplace: workplace.
	task continuation: #continuation.
	workplace stub findWorkerExecutingCurrentTask willReturn: worker.
		
	task retryExecution.

	worker should receive retryTask: task
]

{ #category : #tests }
PtyTaskTest >> testRetryExecutionWhenTaskWasNotStarted [

	| workplace error |
	workplace := Mock new.
	task workplace: workplace.
	task continuation: nil.
		
	error := [task retryExecution] should fail.
	error where description should includeSubstring: 'No continuation'
]
