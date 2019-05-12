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
PtyWorkerTest >> testFailedTaskExecution [

	| error |
	error := Error new.
	task stub body willRaise: error.
		
	worker executeTask: task.
	
	workplace should receive notifyUserAbout: error
	
]

{ #category : #tests }
PtyWorkerTest >> testFailedTaskExecutionNotificationShouldExpectNewUserRequests [

	| request |
	task stub body willRaise: Error new.
	request := PtyUserRequestStub new.
	(workplace stub notifyUserAbout: Any) willRaise: request.
		
	worker executeTask: task.
	
	request should be isExecuted
	
]

{ #category : #tests }
PtyWorkerTest >> testRunTaskInBackgroundProcess [
		
	worker runTask: task.
	
	task should receive body inAnotherProcess
]

{ #category : #tests }
PtyWorkerTest >> testRunTaskInBackgroundProcessWithTaskExecutionPriority [

	worker runTask: task.
	
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
PtyWorkerTest >> testTaskExecution [

	worker executeTask: task.
	
	task should receive body
]

{ #category : #tests }
PtyWorkerTest >> testTaskExecutionShouldExpectUserRequest [

	| request |
	request := PtyUserRequestStub new.
	task stub body willRaise: request.
		
	worker executeTask: task.
	
	request should be isExecuted
]

{ #category : #tests }
PtyWorkerTest >> testTaskExecutionWhenWorkerIsAlreadyActive [

	| result |
	worker stub isActive willReturn: true.
	
	result := worker executeTask: task.
	
	result should beReturnedFrom: [ task body].
	worker activeTask should be: task
]
