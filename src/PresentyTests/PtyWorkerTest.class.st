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
PtyWorkerTest >> testContinueWithTask [
	
	| executionStage result |
	executionStage := Mock new.
	task stub currentExecutionStage willReturn: executionStage.	
		
	result := worker continueWithTask: task.
	
	result should beReturnedFrom: [executionStage continueExecution].
]

{ #category : #tests }
PtyWorkerTest >> testDefaultExecutionPriorityIsReturnedFromWorkspace [
		
	worker defaultTaskExecutionPriority should beReturnedFrom: [ workplace defaultTaskExecutionPriority ]
]

{ #category : #tests }
PtyWorkerTest >> testDeferringTaskShouldJustRegisterItInWorkplace [

	worker deferTask: task.
	
	workplace should receive registerActiveTask: task.
	task should not receive body
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
		
	worker runInitialTask: task.
	
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
PtyWorkerTest >> testTaskExecutionShouldRegisterTaskAtWorkplace [
	
	worker executeTask: task.
	
	workplace should receive registerActiveTask: task
]

{ #category : #tests }
PtyWorkerTest >> testTaskExecutionWhenWorkerIsAlreadyActive [

	| result |
	worker stub isActive willReturn: true.
	
	result := worker executeTask: task.
	
	result should beReturnedFrom: [ worker continueWithTask: task].
	worker activeTask should be: task
]

{ #category : #tests }
PtyWorkerTest >> testTaskExecutionWhenWorkerIsNotActiveYet [

	worker stub isActive willReturn: false.

	worker executeTask: task.
	
	worker should receive startWithTask: task. 
	worker activeTask should be: task
]
