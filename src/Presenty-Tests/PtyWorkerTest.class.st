Class {
	#name : #PtyWorkerTest,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'worker',
		'task'
	],
	#category : #'Presenty-Tests-Tasks'
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
PtyWorkerTest >> testActiveWorkflow [
		
	worker activeTask: task.
		
	worker activeWorkflow should beReturnedFrom: [ task workflow ]
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldResetActiveTaskAtTheEnd [
		
	worker activeTask: task.
		
	worker continueWorkflowWithTask: task usingStartStage: #startTaskStage.
	
	worker activeTask should beReturnedFrom: [ task parentTask ]
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldSetActiveTaskBeforeRun [
	
	| currentWorkflowStage |
	currentWorkflowStage := Mock new.
	(task stub currentWorkflowStageStartedWith: #startTaskStage) willReturn: currentWorkflowStage.	

	currentWorkflowStage stub continueWorkflow when: [ worker activeTask ] is: task.	
	worker continueWorkflowWithTask: task usingStartStage: #startTaskStage
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskShouldUseCurrentWorkflowStageOfThisTask [
	
	| currentWorkflowStage result |
	currentWorkflowStage := Mock new.
	(task stub currentWorkflowStageStartedWith: #startTaskStage) willReturn: currentWorkflowStage.	
		
	result := worker continueWorkflowWithTask: task usingStartStage: #startTaskStage.
	
	result should beReturnedFrom: [currentWorkflowStage continueWorkflow]
]

{ #category : #tests }
PtyWorkerTest >> testContinueWithTaskUsingGivenExecutionStage [
		
	worker continueWorkflowWithTask: task usingStartStage: #taskStartStage.
	
	task should receive currentWorkflowStageStartedWith: #taskStartStage.
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
	task stub workflow willReturn: #workflow.
	
	worker runInitialTask: task usingStartStage: #startTaskStage.
	
	[worker continueWorkflowWithTask: task usingStartStage: #startTaskStage.
	workplace endWorkSessionFor: #workflow ] should beDoneInOrder 
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskExecutionShouldExpectUserRequest [

	| request |
	request := PtyUserRequest new.
	(worker stub continueWorkflowWithTask: task usingStartStage: #startTaskStage) willRaise: request.
		
	worker runInitialTask: task usingStartStage: #startTaskStage.
	
	workplace should receive endWorkSessionFor: Any.
	worker should not receive notifyUserAbout: request
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskExecutionShouldFirstStartNewSession [
	worker stub.
	
	worker runInitialTask: task usingStartStage: #startTaskStage.

	[task startNewSession.	
	worker continueWorkflowWithTask: task usingStartStage: #startTaskStage] should beDoneInOrder 
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskFailedExecution [

	| error |
	error := Error new.
	(worker stub continueWorkflowWithTask: task usingStartStage: #startTaskStage) willRaise: error.
		
	[worker runInitialTask: task usingStartStage: #startTaskStage] should raise: error.
	worker should receive notifyUserAbout: error
]

{ #category : #tests }
PtyWorkerTest >> testInitialTaskFailedExecutionNotificationShouldExpectNewUserRequests [

	| request |
	(worker stub continueWorkflowWithTask: task usingStartStage: #startTaskStage) willRaise: Error new.
	request := PtyUserRequest new.
	(worker stub notifyUserAbout: Any) willRaise: request.
		
	worker runInitialTask: task usingStartStage: #startTaskStage.
	
	workplace should receive endWorkSessionFor: Any.
	worker should not receive notifyUserAbout: request
]

{ #category : #tests }
PtyWorkerTest >> testIsActiveWhenItRunsActiveProcess [

	worker process: Processor activeProcess.	
	
	worker should be isActive
]

{ #category : #tests }
PtyWorkerTest >> testIsAnotherWorkerActive [

	| activeWorkflow |
	activeWorkflow := Mock new.
	(workplace stub findActiveWorkflowIfNone: Any) willReturn: activeWorkflow.
	activeWorkflow stub worker willReturn: #anotherWorker.
	
	worker should be isAnotherWorkerActive
]

{ #category : #tests }
PtyWorkerTest >> testIsAnotherWorkerActiveWhenItIsCurrentActiveWorkflow [

	| activeWorkflow |
	activeWorkflow := Mock new.
	(workplace stub findActiveWorkflowIfNone: Any) willReturn: activeWorkflow.
	activeWorkflow stub worker willReturn: worker.
	
	worker should not be isAnotherWorkerActive
]

{ #category : #tests }
PtyWorkerTest >> testIsAnotherWorkerActiveWhenNoActiveWorkflowExists [

	(workplace stub findActiveWorkflowIfNone: Any) will: [ :block | block value ].
	
	worker should not be isAnotherWorkerActive
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
PtyWorkerTest >> testSettings [
	
	worker settings should beReturnedFrom: [ workplace settings ]
]

{ #category : #tests }
PtyWorkerTest >> testStartingWorkflowShouldBeDoneInBackgroundProcess [
	worker stub.
			
	worker startWorkflowWithTask: task usingStartStage: #taskStartStage.

	(worker should receive continueWorkflowWithTask: task usingStartStage: #taskStartStage) inAnotherProcess
]

{ #category : #tests }
PtyWorkerTest >> testStartingWorkflowShouldUseTaskExecutionPriority [
	worker stub.
	
	worker startWorkflowWithTask: task usingStartStage: #taskStartStage.
	
	(worker should receive continueWorkflowWithTask: task usingStartStage: #taskStartStage)
		inProcessWhich priority should equal: task executionPriority
]

{ #category : #tests }
PtyWorkerTest >> testStartingWorkflowWithoutExplicitStartStage [

	worker stub startWorkflowWithTask: task usingStartStage: Arg stage.
			
	worker startWorkflowWithTask: task.

	Arg stage should beInstanceOf: PtyTaskStartStage. 
	Arg stage where task should be: task.
]

{ #category : #tests }
PtyWorkerTest >> testStoppingWorkflow [

	| process |
	process := Mock new.

	worker process: process.	
	worker stopWorkflow.
	
	process should receive terminate
]

{ #category : #tests }
PtyWorkerTest >> testStoppingWorkflowWhenNoProcess [

	worker process: nil.
	
	worker stopWorkflow
]

{ #category : #tests }
PtyWorkerTest >> testWorkflowStageExecutionFromAnotherActiveWorker [

	| stage |
	worker stub isActive willReturn: false.
	worker stub isAnotherWorkerActive willReturn: true.
	stage := Mock new.
	
	[worker executeWorkflowStage: stage] should raise: PtyUserRequest.
	stage should receive startInInactiveWorkflowBy: worker
]

{ #category : #tests }
PtyWorkerTest >> testWorkflowStageExecutionFromOutsideOfWorkplace [

	| result stage |
	worker stub isActive willReturn: false.
	worker stub isAnotherWorkerActive willReturn: false.
	stage := Mock new.
	
	result := worker executeWorkflowStage: stage.
	
	result should beReturnedFrom: [ stage startInInactiveWorkflowBy: worker]
]

{ #category : #tests }
PtyWorkerTest >> testWorkflowStageExecutionItsActiveWorker [

	| result stage |
	worker stub isActive willReturn: true.
	stage := Mock new.
	
	result := worker executeWorkflowStage: stage.
	
	result should beReturnedFrom: [ stage startInActiveWorkflowBy: worker]
]
