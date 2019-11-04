Class {
	#name : #PtyWorkSessionTest,
	#superclass : #TestCase,
	#instVars : [
		'session'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkSessionTest >> setUp [
	super setUp.
	
	session := PtyWorkSession new
]

{ #category : #tests }
PtyWorkSessionTest >> testCurrentTasks [

	| workflow1 workflow2 allTasks |
	workflow1 := PtyWorkflow new.
	workflow1 registerNewTask: #task1.
	workflow2 := PtyWorkflow new.
	workflow2 registerNewTask: #task2.
	session addWorkflow: workflow1; addWorkflow: workflow2.
	
	allTasks := session currentTasks.
	
	allTasks should equal: #(task1 task2)
]

{ #category : #tests }
PtyWorkSessionTest >> testFindingWorkflowWithGivenTask [

	| someWorkflow targetWorkflow found |
	someWorkflow := PtyWorkflow new.
	someWorkflow registerNewTask: #someOtherTask.
	targetWorkflow := PtyWorkflow new.
	targetWorkflow registerNewTask: #task.
	session addWorkflow: someWorkflow; addWorkflow: targetWorkflow.
	
	found := session workflowWith: #task.
	
	found should be: targetWorkflow
]

{ #category : #tests }
PtyWorkSessionTest >> testHasEmptyWorkflowsByDefault [

	session workflows should be isEmpty
]

{ #category : #tests }
PtyWorkSessionTest >> testNewWorkflowAddition [

	| workflow |
	workflow := session addNewWorkflow.
	
	workflow should beInstanceOf: PtyWorkflow.
	workflow workSession should be: session
]

{ #category : #tests }
PtyWorkSessionTest >> testRevertingStateShouldAddMissingWorkflowsRegisteredInGivenSession [
	| anotherSession missingWorkflow |
	missingWorkflow := PtyWorkflow in: session.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: missingWorkflow.
		
	session revertStateTo: anotherSession startingAt: #initialWorkflow.
	
	session workflows should include: missingWorkflow
]

{ #category : #tests }
PtyWorkSessionTest >> testRevertingStateShouldKeepDeepChildSpawnedFromRegisteredWorkflowsInGivenSession [
	| anotherSession existingWorkflow spawnedDeepChild |
	existingWorkflow := PtyWorkflow in: session.
	session addWorkflow: existingWorkflow.
	spawnedDeepChild := existingWorkflow spawnNew spawnNew.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: existingWorkflow.
		
	session revertStateTo: anotherSession startingAt: #initialWorkflow.
	
	session workflows should include: existingWorkflow.
	session workflows should include: spawnedDeepChild
]

{ #category : #tests }
PtyWorkSessionTest >> testRevertingStateShouldKeepWorkflowsRegisteredInGivenSession [
	| anotherSession existingWorkflow1 existingWorkflow2 |
	existingWorkflow1 := PtyWorkflow new.
	existingWorkflow2 := PtyWorkflow new.
	session addWorkflow: existingWorkflow1; addWorkflow: existingWorkflow2.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: existingWorkflow1; addWorkflow: existingWorkflow2.
		
	session revertStateTo: anotherSession startingAt: #initialWorkflow.
	
	session workflows should include: existingWorkflow1.
	session workflows should include: existingWorkflow2.
]

{ #category : #tests }
PtyWorkSessionTest >> testRevertingStateShouldKeepWorkflowsSpawnedFromRegisteredWorkflowsInGivenSession [
	| anotherSession existingWorkflow spawnedWorkflow1 spawnedWorkflow2 |
	existingWorkflow := PtyWorkflow in: session.
	session addWorkflow: existingWorkflow.
	spawnedWorkflow1 := existingWorkflow spawnNew.
	spawnedWorkflow2 := existingWorkflow spawnNew.	
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: existingWorkflow.
		
	session revertStateTo: anotherSession startingAt: #initialWorkflow.
	
	session workflows should include: existingWorkflow.
	session workflows should include: spawnedWorkflow1.
	session workflows should include: spawnedWorkflow2.
]

{ #category : #tests }
PtyWorkSessionTest >> testRevertingStateShouldRemoveExistingChildrenOfGivenInitialWorkflow [
	| anotherSession initialWorkflow spawnedFromInitialWorkflow1 spawnedFromInitialWorkflow2 |
	initialWorkflow := PtyWorkflow in: session.
	session addWorkflow: initialWorkflow.
	spawnedFromInitialWorkflow1 := initialWorkflow spawnNew.
	spawnedFromInitialWorkflow2 := initialWorkflow spawnNew..
	anotherSession := PtyWorkSession new.
		
	session revertStateTo: anotherSession startingAt: initialWorkflow.
	
	session workflows should not include: spawnedFromInitialWorkflow1.
	session workflows should not include: spawnedFromInitialWorkflow2.
]

{ #category : #tests }
PtyWorkSessionTest >> testRevertingStateShouldRemoveExistingDeepChildOfGivenInitialWorkflow [
	| anotherSession initialWorkflow spawnedDeepChild |
	initialWorkflow := PtyWorkflow in: session.
	session addWorkflow: initialWorkflow.
	spawnedDeepChild  := initialWorkflow spawnNew spawnNew.
	anotherSession := PtyWorkSession new.
		
	session revertStateTo: anotherSession startingAt: initialWorkflow.
	
	session workflows should not include: spawnedDeepChild
]

{ #category : #tests }
PtyWorkSessionTest >> testSpawnNewSession [ 

	| newSession workflow |
	workflow := session addNewWorkflow.
	workflow registerNewTask: PtyTask new.
	
	newSession := session spawnNew.
	
	newSession parentSession should be: session.
	newSession workflows should equal: session workflows.
	newSession workflows should not be: session workflows
]
