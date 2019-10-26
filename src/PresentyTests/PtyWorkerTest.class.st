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
PtyWorkerTest >> testCapturingInitialWorkflowForTask [

	| workflow |
	workflow := worker captureInitialWorkflowFor: #task.
	
	workflow should beReturnedFrom: [workplace captureInitialWorkflowFor: #task]
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldRegisterItInWorkplaceBeforeExecution [
		
	worker continueWithTask: task.
	
	[workplace registerNewTask: task.
	task currentExecutionStage] should beDoneInOrder.
	
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldResetCurrentTaskAtTheEnd [
		
	worker currentTask: task.
		
	worker continueWithTask: task.
	
	worker currentTask should beReturnedFrom: [ task parentTask ]
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
PtyWorkerTest >> testDefaultExecutionPriorityIsReturnedFromWorkspace [
		
	worker defaultTaskExecutionPriority should beReturnedFrom: [ workplace defaultTaskExecutionPriority ]
]

{ #category : #tests }
PtyWorkerTest >> testDeferringTaskShouldJustRegisterItInWorkplace [

	worker deferTask: task.
	
	workplace should receive registerNewTask: task.
	task should not receive body
]

{ #category : #tests }
PtyWorkerTest >> testDeferringTaskShouldReturnFutureResult [

	| result |
	result := worker deferTask: task.
	
	result should beInstanceOf: PtyTaskExecutionFutureResult.
	result task should be: task
]

{ #category : #tests }
PtyWorkerTest >> testDeliveringTaskResultWhenWorkerIsAlreadyActive [

	worker stub isActive willReturn: true.

	worker deliverResult: #taskResult of: task.
	
	task should receive completeExecutionWith: #taskResult
]

{ #category : #tests }
PtyWorkerTest >> testDeliveringTaskResultWhenWorkerIsNotActiveYet [

	worker stub isActive willReturn: false.
	(worker stub startWithTask: Arg task) willReturnYourself. 
	
	worker deliverResult: #taskResult of: task.
	
	Arg task should beInstanceOf: PtyDeliverResultTask.
	Arg task where completeTask should be: task.
	Arg task where result should be: #taskResult
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskExecution [

	worker runInitialTask: task.
	
	task should receive startExecution 
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskExecutionShouldExpectUserRequest [

	| request |
	request := PtyUserRequestStub new.
	task stub startExecution willRaise: request.
		
	worker runInitialTask: task.
	
	request should be isExecuted
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskFailedExecution [

	| error |
	worker stub.
	error := Error new.
	task stub startExecution willRaise: error.
		
	[worker runInitialTask: task] should raise: error.
	worker should receive notifyUserAbout: error
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskFailedExecutionNotificationShouldExpectNewUserRequests [

	| request |
	worker stub.
	task stub startExecution willRaise: Error new.
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
PtyWorkerTest >> testRemovingTask [

	worker removeTask: task.
	
	workplace should receive removeTask: task.
]

{ #category : #tests }
PtyWorkerTest >> testStartWithTaskInBackgroundProcess [
		
	worker startWithTask: task.
	
	task should receive startExecution inAnotherProcess
]

{ #category : #tests }
PtyWorkerTest >> testStartWithTaskShouldStartNewWorkSessionForIt [

	worker startWithTask: task.
	
	[workplace startWorkSessionBy: worker.
	task startExecution] should beDoneInOrder
]

{ #category : #tests }
PtyWorkerTest >> testStartWithTaskUsingTaskExecutionPriority [

	worker startWithTask: task.
	
	task should receive startExecution
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
PtyWorkerTest >> testTaskExecutionShouldFirstSetCurrentTask [

	worker stub isActive 
		when: [worker currentTask] is: task.
	
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
