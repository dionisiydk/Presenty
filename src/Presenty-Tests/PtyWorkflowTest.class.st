Class {
	#name : #PtyWorkflowTest,
	#superclass : #TestCase,
	#instVars : [
		'workflow',
		'worker'
	],
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyWorkflowTest >> setUp [
	super setUp.
	
	worker := Mock new.
	workflow := PtyWorkflow new.
	workflow worker: worker
]

{ #category : #tests }
PtyWorkflowTest >> testActivationControlPanelWhenOnlySpawnedWorkflowsAndNoOwnTasks [
	
	| spawnedWorklow controlPanel |
	controlPanel := Mock new.
	spawnedWorklow := workflow spawnNew.
	spawnedWorklow stub controlPanel willReturn: controlPanel.
	
	workflow activateControlPanel.
	
	controlPanel should receive activateOnPanel
]

{ #category : #tests }
PtyWorkflowTest >> testActiveTask [ 

	workflow worker: worker.
	
	workflow activeTask should beReturnedFrom: [ worker activeTask ]
]

{ #category : #tests }
PtyWorkflowTest >> testActiveTaskWhenThereIsNoWorker [ 

	workflow worker: nil.
	
	workflow activeTask should be: nil
]

{ #category : #tests }
PtyWorkflowTest >> testAllCurrentTasksShouldIncludeSpawnedWorkflows [
	
	| spawned1 spawned2 |
	workflow registerNewTask: #newTask.
	spawned1 := workflow spawnNew.
	spawned1 registerNewTask: #newTask2.
	spawned2 := spawned1 spawnNew.
	spawned2 registerNewTask: #newTask3.
	
	workflow allCurrentTasks should equal: #(newTask newTask2 newTask3)
]

{ #category : #tests }
PtyWorkflowTest >> testAllCurrentTasksWhenNothingWasSpawned [
	
	workflow registerNewTask: #newTask.
		
	workflow allCurrentTasks should equal: #(newTask)
]

{ #category : #tests }
PtyWorkflowTest >> testCaptureState [ 

	| capturedWorkflow |
	workflow registerNewTask: #existingTask.
	
	capturedWorkflow := workflow captureState.
	
	capturedWorkflow currentTasks should include: #existingTask.
	capturedWorkflow currentTasks should not be: workflow currentTasks
]

{ #category : #tests }
PtyWorkflowTest >> testCaptureStateShouldCopySpawnedWorkflowsList [

	| capturedWorkflow forkedWorkflow |
	forkedWorkflow := workflow spawnNew.
	
	capturedWorkflow := workflow captureState.
	
	capturedWorkflow spawnedWorkflows should include: forkedWorkflow.
	capturedWorkflow spawnedWorkflows should not be: workflow spawnedWorkflows
]

{ #category : #tests }
PtyWorkflowTest >> testCleaningControlPanel [
	
	| task1 task2 panel1 panel2 |
	task1 := Mock new. task2 := Mock new.
	panel1 := Mock new. panel2 := Mock new.
	task1 stub controlPanel willReturn: panel1.
	task2 stub controlPanel willReturn: panel2.
	workflow currentTasks: { task1. task2 }.
	
	workflow cleanControlPanel.
	
	panel1 should receive removeAllTools.
	panel2 should receive removeAllTools
]

{ #category : #tests }
PtyWorkflowTest >> testCleaningControlPanelShouldCleanSpawnedWorkflows [
	
	workflow spawnNew stub.
	
	workflow cleanControlPanel.
	
	workflow spawnedWorkflows first should receive cleanControlPanel
]

{ #category : #tests }
PtyWorkflowTest >> testControlPanel [
	
	| task actual |
	task := Mock new. 
	workflow currentTasks: { task }.
	
	actual := workflow controlPanel.
	
	actual should beReturnedFrom: [ task controlPanel ]
]

{ #category : #tests }
PtyWorkflowTest >> testDefaultTaskExecutionPriority [

	| result worker |
	worker := Mock new.
	workflow worker: worker.
	
	result := workflow defaultTaskExecutionPriority.
	
	result should beReturnedFrom: [ worker defaultTaskExecutionPriority]
]

{ #category : #tests }
PtyWorkflowTest >> testDeferingTaskShouldExecuteDeferingWorkflowStage [

	| result |
	(worker stub executeWorkflowStage: Arg stage) willReturn: #result.
	
	result := workflow deferTask: #task.
	
	result should be: #result.
	Arg stage should beInstanceOf: PtyTaskDefermentStage.
	Arg stage where task should be: #task
]

{ #category : #tests }
PtyWorkflowTest >> testDeferingTaskShouldRegisterItInCurrentTasks [

	workflow deferTask: #task.
	
	workflow currentTasks should include: #task
]

{ #category : #tests }
PtyWorkflowTest >> testDeliveringTaskResult [

	| result |
	worker stub executeWorkflowStage: Arg stage.
	
	result := workflow deliverResult: #result of: #task.
	
	Arg stage should beInstanceOf: PtyTaskResultDeliveryStage.
	Arg stage where task should be: #task
]

{ #category : #tests }
PtyWorkflowTest >> testDisable [

	| parentWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	
	workflow disable.
	
	parentWorkflow should receive removeSpawnedWorkflow: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testDisableIfEmptyWhenNoParentExists [

	workflow parentWorkflow: nil.
	workflow currentTasks should be isEmpty.
	
	workflow disableIfEmpty
]

{ #category : #tests }
PtyWorkflowTest >> testDisableIfEmptyWhenThereAreEmptySpawnedWorkflows [

	| parentWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	workflow spawnNew.
	
	workflow disableIfEmpty.
	
	parentWorkflow should receive removeSpawnedWorkflow: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testDisableIfEmptyWhenThereAreNoRegisteredTasks [

	| parentWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	workflow currentTasks should be isEmpty.
	
	workflow disableIfEmpty.
	
	parentWorkflow should receive removeSpawnedWorkflow: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testDisableIfEmptyWhenThereAreNonEmptySpawnedWorkflows [

	| parentWorkflow spawnedWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	spawnedWorkflow := workflow spawnNew.
	spawnedWorkflow registerNewTask: #task.
	
	workflow disableIfEmpty.
	
	parentWorkflow should not receive anyMessage
]

{ #category : #tests }
PtyWorkflowTest >> testDisableIfEmptyWhenThereAreRegisteredTasks [

	| parentWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	workflow registerNewTask: #task.
	
	workflow disableIfEmpty.
	
	parentWorkflow should not receive anyMessage
]

{ #category : #tests }
PtyWorkflowTest >> testDisableIfItIsRootWorkflow [

	workflow parentWorkflow: nil.
	
	workflow disable
]

{ #category : #tests }
PtyWorkflowTest >> testExecutingTask [

	| result task |
	task := [ ] asTask.
	(worker stub executeWorkflowStage: Arg stage) willReturn: #result.
	
	result := workflow executeTask: task.
	
	result should be: #result.
	Arg stage should beInstanceOf: PtyTaskStartStage.
	Arg stage where task should be: task
]

{ #category : #tests }
PtyWorkflowTest >> testExecutingTaskShouldBindItToCurrentSession [

	| task |
	task := [] asTask.
	workflow currentSession: #session.
	
	workflow executeTask: task.
	
	task workSession should be: #session
]

{ #category : #tests }
PtyWorkflowTest >> testFindActiveWorkflowWhenNoneExists [ 

	| result |
	workflow spawnedWorkflows: #().
	
	result := workflow findActiveWorkflowIfNone: [#none].
	
	result should be: #none
]

{ #category : #tests }
PtyWorkflowTest >> testFindActiveWorkflowWhenThereIsActiveSpawnedWorkflow [ 

	| result childWorkflow |
	childWorkflow := workflow spawnNew.
	childWorkflow stub isActive willReturn: true.
	
	result := workflow findActiveWorkflowIfNone: [#none].
		
	result should be: childWorkflow
]

{ #category : #tests }
PtyWorkflowTest >> testFindActiveWorkflowWhenThereIsSpawnedWorkflowWhichFoundAnActiveOne [

	| result childWorkflow |
	childWorkflow := workflow spawnNew.
	childWorkflow stub isActive willReturn: false.
	(childWorkflow stub findActiveWorkflowIfNone: Any) willReturn: #activeWorkflow.
	
	result := workflow findActiveWorkflowIfNone: [#none].
		
	result should be: #activeWorkflow
]

{ #category : #tests }
PtyWorkflowTest >> testFindActiveWorkflowWhenThereNoSpawnedIsActive [

	| result childWorkflow |
	childWorkflow := workflow spawnNew.
	childWorkflow stub isActive willReturn: false.
	(childWorkflow stub findActiveWorkflowIfNone: Any) will: [:noneBlock | noneBlock value].
	
	result := workflow findActiveWorkflowIfNone: [#none].
		
	result should be: #none
]

{ #category : #tests }
PtyWorkflowTest >> testHasCurrentSessionByDefaultWithEmptyWorkflow [

	| session |
	session := workflow currentSession.
	
	session should beInstanceOf: PtyWorkSession.
	session initialWorkflow should be isEmpty.
	session initialWorkflow should not be: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testHasNoCurrentTasksByDefault [

	workflow currentTasks should be isEmpty
]

{ #category : #tests }
PtyWorkflowTest >> testHasNoSpawnedWorkflowsByDefault [

	workflow spawnedWorkflows should be isEmpty
]

{ #category : #tests }
PtyWorkflowTest >> testIncludesTask [

	workflow should not be includesTask: #someTask.
	
	workflow registerNewTask: #existingTask.
	
	workflow should be includesTask: #existingTask.
]

{ #category : #tests }
PtyWorkflowTest >> testIsActiveWhenWorkerIsActiveAndServesIt [

	| worker |
	worker := Mock new.
	workflow worker: worker.
	worker stub isActive willReturn: true.
	(worker stub servesWorkflow: workflow) willReturn: true.
	
	workflow should be isActive.
]

{ #category : #tests }
PtyWorkflowTest >> testIsNotActiveWhenWorkerIsActiveButDontServeIt [

	| worker |
	worker := Mock new.
	workflow worker: worker.
	worker stub isActive willReturn: true.
	(worker stub servesWorkflow: workflow) willReturn: false.
	
	workflow should not be isActive.
]

{ #category : #tests }
PtyWorkflowTest >> testIsNotActiveWhenWorkerIsNotActive [

	| worker |
	worker := Mock new.
	workflow worker: worker.
	worker stub isActive willReturn: false.

	workflow should not be isActive.
]

{ #category : #tests }
PtyWorkflowTest >> testIsSpawnedFromAnotherWorkflow [

	| anotherWorkflow grandparent |
	anotherWorkflow := PtyWorkflow new.
	workflow should not be isSpawnedFrom: anotherWorkflow.
	
	workflow parentWorkflow: anotherWorkflow.
	workflow should be isSpawnedFrom: anotherWorkflow.
	
	grandparent := PtyWorkflow new.
	anotherWorkflow parentWorkflow: grandparent.
	workflow should be isSpawnedFrom: grandparent.
]

{ #category : #tests }
PtyWorkflowTest >> testRegisteringNewTask [ 

	workflow registerNewTask: #task.
	
	workflow currentTasks should include: #task
]

{ #category : #tests }
PtyWorkflowTest >> testRemoveAllTasks [
	
	workflow registerNewTask: #existingTask.
	workflow spawnNew.
	
	workflow removeAllTasks.
	
	workflow currentTasks should be isEmpty.
	workflow spawnedWorkflows should be isEmpty
]

{ #category : #tests }
PtyWorkflowTest >> testRemoveSpawnedWorkflow [ 

	| newWorkflow |
	newWorkflow := workflow spawnNew.
	
	workflow removeSpawnedWorkflow: newWorkflow.
	
	workflow spawnedWorkflows should not include: newWorkflow
]

{ #category : #tests }
PtyWorkflowTest >> testRemoveTask [ 

	workflow registerNewTask: #task.
	
	workflow removeTask: #task.
	
	workflow currentTasks should not include: #task
]

{ #category : #tests }
PtyWorkflowTest >> testResumingAnotherWorkflowShouldCleanExistingParent [ 
	| anotherWorkflow newParentWorkflow existingParent |
	newParentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: newParentWorkflow.
	existingParent := Mock new.
	workflow parentWorkflow: existingParent.
	
	workflow resumeWorkflow: anotherWorkflow.
	
	existingParent should receive removeSpawnedWorkflow: workflow.
	workflow parentWorkflow should be: newParentWorkflow.
]

{ #category : #tests }
PtyWorkflowTest >> testResumingAnotherWorkflowShouldPrepareItsParent [ 
	| parentWorkflow anotherWorkflow |
	parentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: parentWorkflow.
	workflow parentWorkflow: parentWorkflow.
	
	workflow resumeWorkflow: anotherWorkflow.
	
	parentWorkflow should receive resumeSpawnedWorkflow: workflow.
]

{ #category : #tests }
PtyWorkflowTest >> testResumingAnotherWorkflowShouldSetNewCurrentTasks [ 
	| anotherWorkflow |
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow registerNewTask: #newTask.
	
	workflow registerNewTask: #existingTask.	
	workflow resumeWorkflow: anotherWorkflow.
	
	workflow currentTasks should equal: #(newTask).
	workflow currentTasks should not be: anotherWorkflow currentTasks.
]

{ #category : #tests }
PtyWorkflowTest >> testResumingAnotherWorkflowShouldSetNewParent [ 
	| anotherWorkflow newParentWorkflow |
	newParentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: newParentWorkflow.
	
	workflow resumeWorkflow: anotherWorkflow.
	
	workflow parentWorkflow should be: newParentWorkflow
]

{ #category : #tests }
PtyWorkflowTest >> testResumingAnotherWorkflowShouldSetNewSpawnedWorkflows [ 
	| anotherWorkflow spawnedWorkflow |
	anotherWorkflow := PtyWorkflow new.
	spawnedWorkflow := anotherWorkflow spawnNew.
	workflow spawnNew.
	
	workflow resumeWorkflow: anotherWorkflow.
	
	workflow spawnedWorkflows should equal: {spawnedWorkflow}.
	workflow spawnedWorkflows should not be: anotherWorkflow spawnedWorkflows
]

{ #category : #tests }
PtyWorkflowTest >> testResumingSpawnedWorkflow [ 

	| newWorkflow parentWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	newWorkflow := PtyWorkflow new.
	
	workflow resumeSpawnedWorkflow: newWorkflow.
	
	workflow spawnedWorkflows should include: newWorkflow.
	parentWorkflow should receive resumeSpawnedWorkflow: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testResumingSpawnedWorkflowWhenItIsAlreadyEnabled [

	| newWorkflow parentWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	newWorkflow := workflow spawnNew.
	
	workflow resumeSpawnedWorkflow: newWorkflow.
	
	workflow spawnedWorkflows should haveSize: 1.
	parentWorkflow should receive resumeSpawnedWorkflow: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testResumingSpawnedWorkflowWhenNoParentExists [

	| newWorkflow |
	workflow parentWorkflow: nil.
	newWorkflow := PtyWorkflow new.
	
	workflow resumeSpawnedWorkflow: newWorkflow.
	
	workflow spawnedWorkflows should include: newWorkflow
]

{ #category : #tests }
PtyWorkflowTest >> testRetryingTask [

	(worker stub executeWorkflowStage: Arg stage) willReturn: #result.
	
	workflow retryTask: #task.
	
	Arg stage should beInstanceOf: PtyTaskRetryStage.
	Arg stage where task should be: #task
]

{ #category : #tests }
PtyWorkflowTest >> testSettings [
	
	workflow settings should beReturnedFrom: [ worker settings ]
]

{ #category : #tests }
PtyWorkflowTest >> testSpawnNewWorkflow [ 

	| newWorkflow |
	workflow registerNewTask: #existingTask.
	workflow worker: #worker.
	
	newWorkflow := workflow spawnNew.
	
	newWorkflow parentWorkflow should be: workflow.
	newWorkflow worker should be: #worker.
	workflow spawnedWorkflows should include: newWorkflow.
	newWorkflow currentTasks should be isEmpty.
	newWorkflow currentTasks should not be: workflow currentTasks
]

{ #category : #tests }
PtyWorkflowTest >> testStartingNewSession [

	| session |
	session := workflow startNewSession.
	
	session should beInstanceOf: PtyWorkSession.
	session should be: workflow currentSession
]

{ #category : #tests }
PtyWorkflowTest >> testStartingNewSessionShouldCaptureWorkflowState [

	| session |
	workflow stub.
	session := workflow startNewSession.
	
	session initialWorkflow should beReturnedFrom: [ workflow captureState ]
]

{ #category : #tests }
PtyWorkflowTest >> testStoppingTask [

	(worker stub executeWorkflowStage: Arg stage) willReturn: #result.
	
	workflow stopTask: #task.
	
	Arg stage should beInstanceOf: PtyTaskStopStage.
	Arg stage where task should be: #task
]

{ #category : #tests }
PtyWorkflowTest >> testUpdatingControlPanel [
	
	| task1 task2 |
	task1 := Mock new. task2 := Mock new.
	workflow currentTasks: { task1. task2 }.
	
	workflow updateControlPanel.
	
	task1 should receive attachToolsToPanel.
	task2 should receive attachToolsToPanel
]

{ #category : #tests }
PtyWorkflowTest >> testUpdatingControlPanelShouldCleanItFirst [
	
	| task |
	task := Mock new. 
	workflow currentTasks: { task }.
	workflow stub.
	
	workflow updateControlPanel.
	
	[workflow cleanControlPanel.
	task attachToolsToPanel] should beDoneInOrder 
]

{ #category : #tests }
PtyWorkflowTest >> testUpdatingControlPanelShouldUpdateSpawnedWorkflows [
	
	workflow spawnNew stub.
	
	workflow updateControlPanel.
	
	workflow spawnedWorkflows first should receive updateControlPanel.
]
