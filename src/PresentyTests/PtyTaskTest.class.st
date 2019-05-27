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
PtyTaskTest >> testBecomeRequestedForUser [

	| worker |
	worker := Mock new.
	
	task beRequestedFor: #user from: worker.

	task user should be: #user.
	task worker should be: worker.
	task parentTask should beReturnedFrom: [ worker activeTask ] 
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
PtyTaskTest >> testDefaultExecutionPriorityIsReturnedFromWorker [

	| worker |
	worker := Mock new.
	task worker: worker.
	
	task executionPriority should beReturnedFrom: [ worker defaultTaskExecutionPriority ]
]

{ #category : #tests }
PtyTaskTest >> testExecution [

	| executionStrategy result |
	executionStrategy := Mock new.
	task worker: #worker.
	task executionStrategy: executionStrategy.

	result := task requestExecution.

	result should beReturnedFrom: [ executionStrategy requestExecutionOf: task using: #worker ]
]

{ #category : #tests }
PtyTaskTest >> testExecutionAllowsStrategyToPrepareAndCompleteExecution [
	
	| executionStrategy |
	executionStrategy := Mock new.
	task executionStrategy: executionStrategy.
	task worker: #worker.	
	task stub.
	
	task startExecution.

	[executionStrategy prepareExecutionOf: task using: #worker.
	task body.
	executionStrategy completeExecutionOf: task using: #worker] should beDoneInOrder 
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
PtyTaskTest >> testIsOneShotByDefault [

	task executionStrategy should beInstanceOf: PtyOneShotTaskExecution 
]

{ #category : #tests }
PtyTaskTest >> testRequestExecution [

	| executionStrategy result |
	executionStrategy := Mock new.
	task worker: #worker.
	task executionStrategy: executionStrategy.

	result := task requestExecution.

	result should beReturnedFrom: [ executionStrategy requestExecutionOf: task using: #worker ]
]

{ #category : #tests }
PtyTaskTest >> testReturningResult [

	| executionStrategy result |
	self error: 'test'.
	result := task currentExecutionStage. "Prepare continuation".
	
	task returnResult: #taskResult.

	result should beReturnedFrom: [ executionStrategy requestExecutionOf: task using: #worker ]
]
