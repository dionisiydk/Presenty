Class {
	#name : #PtyWorkerTest,
	#superclass : #PtyWorkspaceTestCase,
	#instVars : [
		'worker'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkerTest >> setUp [ 
	super setUp.
	
	worker := PtyWorker at: workspace
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
PtyWorkerTest >> testRunningTask [

	[:task |
		
		[worker runTask: task. 50 milliSeconds asDelay wait]
			should strictly satisfy: 
		[task printString willReturn: 'test task'; useArbitrarily.
		(workspace requestUserFor: task) 
			shouldBeSentInAnotherProcess;
			will: [worker process should be: Processor activeProcess].
		workspace waitUserAction].

	] runWithMocks 
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
