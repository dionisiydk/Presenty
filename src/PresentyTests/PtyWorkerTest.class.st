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
	worker := PtyWorker at: workplace.
	task := Mock new.
	task stub executionPriority willReturn: Processor activePriority + 1
]

{ #category : #tests }
PtyWorkerTest >> testDefaultExecutionPriorityIsReturnedFromWorkspace [
		
	worker defaultTaskExecutionPriority should beReturnedFrom: [ workplace defaultTaskExecutionPriority ]
]

{ #category : #tests }
PtyWorkerTest >> testExecutionTask [

	[:task |
	
		[worker executeTask: task]
			should strictly satisfy: 
		[workplace requestUserFor: task.
		workplace waitUserAction].
	
	] runWithMocks 
]

{ #category : #tests }
PtyWorkerTest >> testExecutionTaskWhenErrorHappen [

	| error request |
	[:task |
		error := Error new.
		request := PtyUserRequestStub new.
		
		[worker executeTask: task]
			should strictly satisfy: 
		[(workplace requestUserFor: task) willRaise: error.
		(workplace notifyUserAbout: error) willRaise: request.
		workplace waitUserAction when: [request isExecuted] is: true].
	
	] runWithMocks 
]

{ #category : #tests }
PtyWorkerTest >> testExecutionTaskWhenUserRequestSignalled [

	| request |
	[:task |
		request := PtyUserRequestStub new.
		
		[worker executeTask: task]
			should strictly satisfy: 
		[(workplace requestUserFor: task) willRaise: request.
		workplace waitUserAction when: [request isExecuted] is: true].
	
	] runWithMocks 
]

{ #category : #tests }
PtyWorkerTest >> testRunTaskInBackgroundProcess [
		
	worker runTask: task.
	
	(workplace should receive requestUserFor: task) inAnotherProcess
]

{ #category : #tests }
PtyWorkerTest >> testRunTaskInBackgroundProcessWithTaskExecutionPriority [

	worker runTask: task.
	
	(workplace should receive requestUserFor: task) 
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
