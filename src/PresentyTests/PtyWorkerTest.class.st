Class {
	#name : #PtyWorkerTest,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'worker',
		'task'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkerTest >> setUp [ 
	super setUp.
	
	workplace := Mock new.
	worker := PtyWorker atWorkplace: workplace.
	task := Mock new.
	task stub executionPriority willReturn: Processor activePriority + 1
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldResetActiveTaskAtTheEnd [
		
	worker activeTask: task.
		
	worker continueWithTask: task.
	
	worker activeTask should beReturnedFrom: [ task parentTask ]
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldRunExecutionStage [
	
	| executionStage result |
	executionStage := Mock new.
	task stub currentExecutionStage willReturn: executionStage.	
		
	result := worker continueWithTask: task.
	
	result should beReturnedFrom: [executionStage continueExecution]
]

{ #category : #tests }
PtyWorkerTest >> testDeliveringTaskResultWhenWorkerIsAlreadyActive [

	worker stub isActive willReturn: true.

	worker deliverResult: #taskResult of: task.
	
	task should receive jumpToResultDeliveryStageWith: #taskResult
]

{ #category : #tests }
PtyWorkerTest >> testDeliveringTaskResultWhenWorkerIsNotActiveYet [

	worker stub isActive willReturn: false.
	(worker stub startWithTask: Arg task) willReturnYourself. 
	
	worker deliverResult: #taskResult of: task.
	
	Arg task should beInstanceOf: PtyDeliverResultTask.
	Arg task where executingTask should be: task.
	Arg task where result should be: #taskResult
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskExecution [
	worker stub.
	
	worker runInitialTask: task.
	
	worker should receive continueWithTask: task
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskExecutionShouldExpectUserRequest [

	| request |
	request := PtyUserRequestStub new.
	(worker stub continueWithTask: task) willRaise: request.
		
	worker runInitialTask: task.
	
	request should be isExecuted
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskFailedExecution [

	| error |
	error := Error new.
	(worker stub continueWithTask: task) willRaise: error.
		
	[worker runInitialTask: task] should raise: error.
	worker should receive notifyUserAbout: error
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskFailedExecutionNotificationShouldExpectNewUserRequests [

	| request |
	(worker stub continueWithTask: task) willRaise: Error new.
	request := PtyUserRequestStub new.
	(worker stub notifyUserAbout: Any) willRaise: request.
		
	worker runInitialTask: task.
	
	request should be isExecuted
]

{ #category : #tests }
PtyWorkerTest >> testIsActiveWhenItRunsActiveProcess [

	worker process: Processor activeProcess.	
	
	worker should be isActive
]

{ #category : #tests }
PtyWorkerTest >> testIsNotActiveWhenItDoesNotRunActiveProcess [

	worker process: [] newProcess.	
	
	worker should not be isActive
]

{ #category : #tests }
PtyWorkerTest >> testIsNotActiveWhenItIsNotStartedYet [

	worker process: nil.
	
	worker should not be isActive
]

{ #category : #tests }
PtyWorkerTest >> testNotifyingUserAboutError [
	
	| error |
	error := Error new messageText: 'test error'.

	[ 
		[error signal] on: Error do: [ :exc | 
			worker notifyUserAbout: error]
	] should raise: error
]

{ #category : #tests }
PtyWorkerTest >> testRetryingTaskWhenWorkerIsAlreadyActive [

	worker stub isActive willReturn: true.

	worker retryTask: task.
	
	task should receive jumpToRetryStage
]

{ #category : #tests }
PtyWorkerTest >> testRetryingTaskWhenWorkerIsNotActiveYet [

	worker stub isActive willReturn: false.
	(worker stub startWithTask: Arg task) willReturnYourself. 
	
	worker retryTask: task.
	
	Arg task should beInstanceOf: PtyRetryTask.
	Arg task where executingTask should be: task
]

{ #category : #tests }
PtyWorkerTest >> testStartWithTaskInBackgroundProcess [
	worker stub.
			
	worker startWithTask: task.

	(worker should receive continueWithTask: task) inAnotherProcess
]

{ #category : #tests }
PtyWorkerTest >> testStartWithTaskShouldRegisterItselfInWorkplace [
	worker stub.
	
	worker startWithTask: task.
	
	[workplace registerWorker: worker.
	worker continueWithTask: task] should beDoneInOrder
]

{ #category : #tests }
PtyWorkerTest >> testStartWithTaskUsingTaskExecutionPriority [
	worker stub.
	
	worker startWithTask: task.
	
	(worker should receive continueWithTask: task)
		inProcessWhich priority should equal: task executionPriority
]

{ #category : #tests }
PtyWorkerTest >> testStoppingTask [

	| process |
	process := Mock new.

	worker process: process.	
	worker stopTask.
	
	process should receive terminate
]

{ #category : #tests }
PtyWorkerTest >> testStoppingTaskWhenNoProcess [

	worker process: nil.
	
	worker stopTask
]

{ #category : #tests }
PtyWorkerTest >> testTaskExecutionShouldFirstSetActiveTask [

	worker stub isActive 
		when: [worker activeTask] is: task.
	
	worker executeTask: task
]

{ #category : #tests }
PtyWorkerTest >> testTaskExecutionWhenWorkerIsAlreadyActive [

	| result |
	worker stub isActive willReturn: true.
	
	result := worker executeTask: task.
	
	result should beReturnedFrom: [ worker continueWithTask: task]
]

{ #category : #tests }
PtyWorkerTest >> testTaskExecutionWhenWorkerIsNotActiveYet [

	| result |
	worker stub isActive willReturn: false.

	result := worker executeTask: task.
	
	result should beInstanceOf: PtyTaskExecutionFutureResult.
	result task should be: task.
	worker should receive startWithTask: task
	
]
