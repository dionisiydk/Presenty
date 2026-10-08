Class {
	#name : #PtyWorkerTest,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'worker',
		'workflowStage'
	],
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyWorkerTest >> setUp [ 
	super setUp.
	
	workplace := Mock new.
	worker := PtyWorker inWorkplace: workplace.
	workflowStage := Mock new.
	workflowStage stub executionPriority willReturn: Processor activePriority + 1
]

{ #category : #tests }
PtyWorkerTest >> testActiveTask [
		
	worker activeWorkflowStage: workflowStage.
		
	worker activeTask should beReturnedFrom: [ workflowStage task ]
]

{ #category : #tests }
PtyWorkerTest >> testActiveTaskWhenNoStage [
		
	worker activeWorkflowStage: nil.
		
	worker activeTask should be: nil
]

{ #category : #tests }
PtyWorkerTest >> testActiveWorkflow [
		
	worker activeWorkflowStage: workflowStage.
		
	worker activeWorkflow should beReturnedFrom: [ workflowStage workflow ]
]

{ #category : #tests }
PtyWorkerTest >> testContinueWorkflowShouldPrepareWorkflowBeforeStageExecution [
	
	worker activeWorkflowStage: workflowStage.
		
	worker continueWorkflowIntoStage: workflowStage.
	
	[ workflowStage prepareWorkflow. workflowStage continueWorkflow ] should beDoneInOrder
]

{ #category : #tests }
PtyWorkerTest >> testContinueWorkflowShouldRestorePreviousStageAtTheEnd [
		
	worker activeWorkflowStage: #previousStage.
		
	worker continueWorkflowIntoStage: workflowStage.
	
	worker activeWorkflowStage should be: #previousStage
]

{ #category : #tests }
PtyWorkerTest >> testContinueWorkflowShouldReturnResultOfNewStageExecution [
	
	| result |
	worker activeWorkflowStage: workflowStage.
		
	result := worker continueWorkflowIntoStage: workflowStage.
	
	result should beReturnedFrom: [ workflowStage continueWorkflow ]
]

{ #category : #tests }
PtyWorkerTest >> testContinueWorkflowShouldSetNewActiveStageBeforeExecution [
	
	worker activeWorkflowStage: #previousStage.

	workflowStage stub prepareWorkflow when: [ worker activeWorkflowStage ] is: workflowStage.	
	worker continueWorkflowIntoStage: workflowStage.
]

{ #category : #tests }
PtyWorkerTest >> testDefaultTaskExecutionPriority [

	| result |
	result := worker defaultTaskExecutionPriority.
	
	result should beReturnedFrom: [ workplace defaultTaskExecutionPriority]
]

{ #category : #tests }
PtyWorkerTest >> testDoesNotServeWorkflowDifferentThanActiveTask [
		
	worker activeWorkflowStage: workflowStage.
	workflowStage stub workflow willReturn: #anotherWorkflow. 
		
	worker should not be servesWorkflow: #workflow
]

{ #category : #tests }
PtyWorkerTest >> testDoesNotServeWorkflowWhenNoActiveTask [
		
	worker activeWorkflowStage should be: nil.
		
	worker should not be servesWorkflow: #workflow
]

{ #category : #tests }
PtyWorkerTest >> testInitialStageExecution [
	worker stub.
	workflowStage stub workflow willReturn: #workflow.
	
	worker runWorkSessionFor: workflowStage.
	
	[workflowStage startNewSession.
	worker continueWorkflowIntoStage: workflowStage.
	workplace endWorkSessionFor: #workflow ] should beDoneInOrder 
]

{ #category : #tests }
PtyWorkerTest >> testInitialStageExecutionShouldExpectUserRequest [

	| request |
	request := PtyUserRequest new.
	(worker stub continueWorkflowIntoStage: workflowStage) willRaise: request.
		
	worker runWorkSessionFor: workflowStage.
	
	workplace should receive endWorkSessionFor: Any.
	worker should not receive notifyUserAbout: request
]

{ #category : #tests }
PtyWorkerTest >> testInitialStageFailedExecution [

	| error |
	error := Error new.
	(worker stub continueWorkflowIntoStage: workflowStage) willRaise: error.
		
	[worker runWorkSessionFor: workflowStage] should raise: error.
	worker should receive notifyUserAbout: error
]

{ #category : #tests }
PtyWorkerTest >> testInitialStageFailedExecutionShouldExpectNewUserRequestsFromErrorNotification [

	| request |
	(worker stub continueWorkflowIntoStage: workflowStage) willRaise: Error new.
	request := PtyUserRequest new.
	(worker stub notifyUserAbout: Any) willRaise: request.
		
	worker runWorkSessionFor: workflowStage.
	
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
		
	worker activeWorkflowStage: workflowStage.
	workflowStage stub workflow willReturn: #workflow. 
		
	worker should be servesWorkflow: #workflow
]

{ #category : #tests }
PtyWorkerTest >> testSettings [
	
	worker settings should beReturnedFrom: [ workplace settings ]
]

{ #category : #tests }
PtyWorkerTest >> testStartingWorkSessionShouldRunWorkflowInBackgroundProcess [
	worker stub.
			
	worker startWorkSessionFor: workflowStage.

	(worker should receive continueWorkflowIntoStage: workflowStage) inAnotherProcess
]

{ #category : #tests }
PtyWorkerTest >> testStartingWorkSessionShouldUseTaskExecutionPriority [
	worker stub.
	
	worker startWorkSessionFor: workflowStage.
	
	(worker should receive continueWorkflowIntoStage:  workflowStage)
		inProcessWhich priority should equal: workflowStage executionPriority
]

{ #category : #tests }
PtyWorkerTest >> testStoppingWorkSession [

	| process |
	process := Mock new.

	worker process: process.	
	worker stopWorkSession.
	
	process should receive terminate
]

{ #category : #tests }
PtyWorkerTest >> testStoppingWorkSessionWhenNoProcess [

	worker process: nil.
	
	worker stopWorkSession
]

{ #category : #tests }
PtyWorkerTest >> testWorkflowStageExecutionFromAnotherActiveWorker [

	| stage |
	worker stub isActive willReturn: false.
	worker stub isAnotherWorkerActive willReturn: true.
	stage := Mock new.
	(worker stub startWorkSessionFor: stage) willReturnYourself.
	
	[worker executeWorkflowStage: stage] should raise: PtyUserRequest.
	worker should receive startWorkSessionFor: stage
]

{ #category : #tests }
PtyWorkerTest >> testWorkflowStageExecutionFromOutsideOfWorkplace [

	| result stage |
	worker stub isActive willReturn: false.
	worker stub isAnotherWorkerActive willReturn: false.
	stage := Mock new.
	(worker stub startWorkSessionFor: stage) willReturnYourself.	
	
	result := worker executeWorkflowStage: stage.
	
	result should beKindOf: PtyTaskExecutionFutureResult
]

{ #category : #tests }
PtyWorkerTest >> testWorkflowStageExecutionItsActiveWorker [

	| result stage |
	worker stub isActive willReturn: true.
	stage := Mock new.
	
	result := worker executeWorkflowStage: stage.
	
	result should beReturnedFrom: [ worker continueWorkflowIntoStage: stage ]
]
