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
PtyWorkerTest >> testDefaultExecutionPriorityIsReturnedFromWorkspace [
		
	worker defaultTaskExecutionPriority should beReturnedFrom: [ workplace defaultTaskExecutionPriority ]
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskExecution [

	worker executeInitialTask: task.
	
	task should receive body
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskExecutionShouldExpectUserRequest [

	| request |
	request := PtyUserRequestStub new.
	task stub body willRaise: request.
		
	worker executeInitialTask: task.
	
	request should be isExecuted
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskFailedExecution [

	| error |
	error := Error new.
	task stub body willRaise: error.
		
	worker executeInitialTask: task.
	
	workplace should receive notifyUserAbout: error
	
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskFailedExecutionNotificationShouldExpectNewUserRequests [

	| request |
	task stub body willRaise: Error new.
	request := PtyUserRequestStub new.
	(workplace stub notifyUserAbout: Any) willRaise: request.
		
	worker executeInitialTask: task.
	
	request should be isExecuted
	
]

{ #category : #tests }
PtyWorkerTest >> testStartWithTaskInBackgroundProcess [
		
	worker startWithTask: task.
	
	task should receive body inAnotherProcess
]

{ #category : #tests }
PtyWorkerTest >> testStartWithTaskUsingTaskExecutionPriority [

	worker startWithTask: task.
	
	task should receive body
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
PtyWorkerTest >> testTaskExecutionWhenWorkerIsAlreadyActive [

	| result |
	worker stub isActive willReturn: true.
	
	result := worker executeTask: task.
	
	result should beReturnedFrom: [ task body].
	worker activeTask should be: task
]

{ #category : #tests }
PtyWorkerTest >> testTaskExecutionWhenWorkerIsNotActiveYet [

	worker stub isActive willReturn: false.

	worker executeTask: task.
	
	worker should receive startWithTask: task. 
	worker activeTask should be: task
]
