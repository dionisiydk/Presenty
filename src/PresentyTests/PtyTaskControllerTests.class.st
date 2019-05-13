Class {
	#name : #PtyTaskControllerTests,
	#superclass : #TestCase,
	#instVars : [
		'guide',
		'controller'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyTaskControllerTests >> setUp [ 
	super setUp.
	
	guide := Mock new.
	controller := PtyTaskController of: guide.
]

{ #category : #tests }
PtyTaskControllerTests >> testFailedTaskExecution [

	| error request |
	[:task |
		error := Error new.
		request := PtyUserRequestStub new.
		
		[controller executeTask: task]
			should strictly satisfy: 
		[(guide requestUserFor: task) willRaise: error.
		(guide notifyUserAbout: error) willRaise: request.
		guide waitUserAction when: [request isExecuted] is: true].
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskControllerTests >> testInitialTaskExecutionShouldExpectUserRequest [

	| request |
	[:task |
		request := PtyUserRequestStub new.
		
		[controller executeTask: task]
			should strictly satisfy: 
		[(guide requestUserFor: task) willRaise: request.
		guide waitUserAction when: [request isExecuted] is: true].
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskControllerTests >> testRunningTask [

	[:task |
		
		[controller runTask: task. 50 milliSeconds asDelay wait]
			should strictly satisfy: 
		[task printString willReturn: 'test task'; useArbitrarily.
		(guide requestUserFor: task) 
			shouldBeSentInAnotherProcess;
			will: [controller process should be: Processor activeProcess].
		guide waitUserAction].

	] runWithMocks 
]

{ #category : #tests }
PtyTaskControllerTests >> testStoppingTask [

	[:process |
		controller process: process.
		
		[controller stopTask]
			should strictly satisfy: 
		[process terminate]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskControllerTests >> testStoppingTaskWhenNoProcess [

	controller process: nil.
	
	controller stopTask
]

{ #category : #tests }
PtyTaskControllerTests >> testTaskExecution [

	[:task |
	
		[controller executeTask: task]
			should strictly satisfy: 
		[guide requestUserFor: task.
		guide waitUserAction].
	
	] runWithMocks 
]
