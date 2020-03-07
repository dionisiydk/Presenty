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
	worker := PtyWorker inWorkplace: workplace.
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
	(task stub currentExecutionStageStartedWith: Any) willReturn: executionStage.	
		
	result := worker continueWithTask: task.
	
	result should beReturnedFrom: [executionStage continueExecution]
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldSetActiveTaskBeforeRun [
	
	| executionStage |
	executionStage := Mock new.
	(task stub currentExecutionStageStartedWith: Any) willReturn: executionStage.	

	executionStage stub continueExecution when: [ worker activeTask ] is: task.	
	worker continueWithTask: task
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldUseStartExecutionStageAsDefault [
	
	task stub currentExecutionStageStartedWith: Arg initialStage.	
		
	worker continueWithTask: task.
	
	Arg initialStage should beInstanceOf: PtyTaskStartStage.
	Arg initialStage where task should be: task
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskUsingGivenExecutionStage [
		
	worker continueWithTask: task using: #initialTaskExecutionStage.
	
	task should receive currentExecutionStageStartedWith: #initialTaskExecutionStage.
]

{ #category : #tests }
PtyWorkerTest >> testDefaultTaskExecutionPriority [

	| result |
	result := worker defaultTaskExecutionPriority.
	
	result should beReturnedFrom: [ workplace defaultTaskExecutionPriority]
]

{ #category : #tests }
PtyWorkerTest >> testDoesNotServeWorkflowDifferentThanActiveTask [
		
	worker activeTask: task.
	task stub workflow willReturn: #anotherWorkflow. 
		
	worker should not be servesWorkflow: #workflow
]

{ #category : #tests }
PtyWorkerTest >> testDoesNotServeWorkflowWhenNoActiveTask [
		
	worker activeTask should be: nil.
		
	worker should not be servesWorkflow: #workflow
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
PtyWorkerTest >> testServesWorkflowOfActiveTask [
		
	worker activeTask: task.
	task stub workflow willReturn: #workflow. 
		
	worker should be servesWorkflow: #workflow
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
PtyWorkerTest >> testWorkflowStageExecutionWhenWorkerIsActive [

	| result stage |
	worker stub isActive willReturn: true.
	stage := Mock new.
	
	result := worker executeWorkflowStage: stage.
	
	result should beReturnedFrom: [ stage startInActiveWorkflowBy: worker]
]

{ #category : #tests }
PtyWorkerTest >> testWorkflowStageExecutionWhenWorkerIsNotActive [

	| result stage |
	worker stub isActive willReturn: false.
	stage := Mock new.
	
	result := worker executeWorkflowStage: stage.
	
	result should beReturnedFrom: [ stage startInInactiveWorkflowBy: worker]
]
