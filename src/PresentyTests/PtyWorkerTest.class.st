Class {
	#name : #PtyWorkerTest,
	#superclass : #PtyWorkspaceTestCase,
	#instVars : [
		'worker',
		'task'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkerTest >> setUp [ 
	super setUp.
	
	workspace := Mock new.
	worker := PtyWorker at: workspace.
	task := Mock new.
	task stub executionPriority willReturn: Processor activePriority + 1
]

{ #category : #tests }
PtyWorkerTest >> testExecutionTask [

	[:task |
	
		[worker executeTask: task]
			should strictly satisfy: 
		[workspace requestUserFor: task.
		workspace waitUserAction].
	
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
		[(workspace requestUserFor: task) willRaise: error.
		(workspace notifyUserAbout: error) willRaise: request.
		workspace waitUserAction when: [request isExecuted] is: true].
	
	] runWithMocks 
]

{ #category : #tests }
PtyWorkerTest >> testExecutionTaskWhenUserRequestSignalled [

	| request |
	[:task |
		request := PtyUserRequestStub new.
		
		[worker executeTask: task]
			should strictly satisfy: 
		[(workspace requestUserFor: task) willRaise: request.
		workspace waitUserAction when: [request isExecuted] is: true].
	
	] runWithMocks 
]

{ #category : #tests }
PtyWorkerTest >> testRunTaskInBackgroundProcess [
		
	worker runTask: task.
	
	(workspace should receive requestUserFor: task) inAnotherProcess
]

{ #category : #tests }
PtyWorkerTest >> testRunTaskInBackgroundProcessWithSpecifiedPriority [

	worker runTask: task.
	
	(workspace should receive requestUserFor: task) 
		inProcessWhich priority should equal: task executionPriority
]

{ #category : #tests }
PtyWorkerTest >> testStoppingTask [

	[:process |
		worker process: process.
		
		[worker stopTask]
			should strictly satisfy: 
		[process terminate]
	] runWithMocks 
]

{ #category : #tests }
PtyWorkerTest >> testStoppingTaskWhenNoProcess [

	worker process: nil.
	
	worker stopTask
]
