Class {
	#name : #PtyWorkflowStateRevertingTest,
	#superclass : #TestCase,
	#instVars : [
		'workflow',
		'workSession'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkflowStateRevertingTest >> setUp [
	super setUp.
	
	workSession := Mock new.
	workflow := PtyWorkflow in: workSession
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testActivatesParent [ 
	| parentWorkflow anotherWorkflow |
	parentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: parentWorkflow.
	workflow parentWorkflow: parentWorkflow.
	
	workflow revertStateTo: anotherWorkflow.
	
	parentWorkflow should receive activateWithSpawnedWorkflow: workflow.
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testCleansExistingParent [ 
	| anotherWorkflow newParentWorkflow existingParent |
	newParentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: newParentWorkflow.
	existingParent := Mock new.
	workflow parentWorkflow: existingParent.
	
	workflow revertStateTo: anotherWorkflow.
	
	existingParent should receive removeSpawnedWorkflow: workflow.
	workflow parentWorkflow should be: newParentWorkflow.
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldAddMissingWorkflowsRegisteredInGivenSession [
	| anotherSession missingWorkflow initialWorkflow |
	missingWorkflow := PtyWorkflow in: workSession.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: missingWorkflow.
		
	initialWorkflow := workSession addNewWorkflow.
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: missingWorkflow
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldAlsoRevertStateOfWorkSession [

	| anotherWorkflow |
	anotherWorkflow := PtyWorkflow in: #anotherSession.
		
	workflow revertStateTo: anotherWorkflow.
	
	workSession should receive revertStateTo: #anotherSession startingAt: workflow
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepChildrenOfParentWorkflowRegisteredInGivenSession [
	| anotherSession initialWorkflow parentWorkflow childOfParentWorkflow |
	parentWorkflow := workSession addNewWorkflow.
	initialWorkflow := parentWorkflow spawnNew.
	childOfParentWorkflow := parentWorkflow spawnNew.	
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: parentWorkflow; addWorkflow: initialWorkflow.		
	
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: childOfParentWorkflow
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepDeepChildSpawnedFromRegisteredWorkflowsInGivenSession [
	| anotherSession existingWorkflow spawnedDeepChild initialWorkflow |
	existingWorkflow := workSession addNewWorkflow.
	spawnedDeepChild := existingWorkflow spawnNew spawnNew.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: existingWorkflow.
	
	initialWorkflow := workSession addNewWorkflow.
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: existingWorkflow.
	workSession workflows should include: spawnedDeepChild
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepExistingChildrenOfGivenInitialWorkflow [
	| anotherSession initialWorkflow spawnedFromInitialWorkflow1 spawnedFromInitialWorkflow2 |
	initialWorkflow := workSession addNewWorkflow.
	spawnedFromInitialWorkflow1 := initialWorkflow spawnNew.
	spawnedFromInitialWorkflow2 := initialWorkflow spawnNew.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: initialWorkflow.
		
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: spawnedFromInitialWorkflow1.
	workSession workflows should include: spawnedFromInitialWorkflow2.
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepExistingDeepChildOfGivenInitialWorkflow [
	| anotherSession initialWorkflow spawnedDeepChild |
	initialWorkflow := workSession addNewWorkflow.
	spawnedDeepChild  := initialWorkflow spawnNew spawnNew.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: initialWorkflow.
		
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: spawnedDeepChild
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepGivenInitialWorkflow [
	| anotherSession initialWorkflow |
	initialWorkflow := workSession addNewWorkflow.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: initialWorkflow.
		
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: initialWorkflow
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepParentWorkflowRegisteredInGivenSession [
	| anotherSession initialWorkflow parentWorkflow |
	parentWorkflow := workSession addNewWorkflow.
	initialWorkflow := parentWorkflow spawnNew.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: parentWorkflow; addWorkflow: initialWorkflow.
		
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: parentWorkflow.
	workSession workflows should include: initialWorkflow.
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepSideParentWorkflowRegisteredInGivenSession [
	| anotherSession initialWorkflow parentWorkflow sideParentWorkflow |
	parentWorkflow := workSession addNewWorkflow.
	sideParentWorkflow := workSession addNewWorkflow.
	initialWorkflow := parentWorkflow spawnNew.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: parentWorkflow; addWorkflow: initialWorkflow.		
	
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: sideParentWorkflow
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepWorkflowsRegisteredInGivenSession [
	| anotherSession existingWorkflow1 existingWorkflow2 initialWorkflow |
	existingWorkflow1 := workSession addNewWorkflow.
	existingWorkflow2 := workSession addNewWorkflow.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: existingWorkflow1; addWorkflow: existingWorkflow2.
		
	initialWorkflow := workSession addNewWorkflow.
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: existingWorkflow1.
	workSession workflows should include: existingWorkflow2.
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldKeepWorkflowsSpawnedFromRegisteredWorkflowsInGivenSession [
	| anotherSession existingWorkflow spawnedWorkflow1 spawnedWorkflow2 initialWorkflow |
	existingWorkflow := workSession addNewWorkflow.
	spawnedWorkflow1 := existingWorkflow spawnNew.
	spawnedWorkflow2 := existingWorkflow spawnNew.	
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: existingWorkflow.
		
	initialWorkflow := workSession addNewWorkflow.
	workSession revertStateTo: anotherSession startingAt: initialWorkflow.
	
	workSession workflows should include: existingWorkflow.
	workSession workflows should include: spawnedWorkflow1.
	workSession workflows should include: spawnedWorkflow2.
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldRemoveNewChildrenOfGivenCapturedInitialWorkflow [
	| anotherSession initialWorkflow capturedChildWorkflow capturedStateOfInitialWorkflow newChildWorkflow |
	initialWorkflow := workSession addNewWorkflow.
	capturedChildWorkflow := initialWorkflow spawnNew.
	capturedStateOfInitialWorkflow := initialWorkflow captureStateForNewTask.
	newChildWorkflow := initialWorkflow spawnNew.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: initialWorkflow.
	capturedStateOfInitialWorkflow workSession: anotherSession.
	
	initialWorkflow revertStateTo: capturedStateOfInitialWorkflow.
	
	workSession workflows should include: capturedChildWorkflow.
	workSession workflows should not include: newChildWorkflow
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testRevertingStateShouldRemoveNewDeepChildOfGivenCapturedInitialWorkflow [
	| anotherSession initialWorkflow capturedStateOfInitialWorkflow capturedDeepChildWorkflow newDeepChildWorkflow |
	initialWorkflow := workSession addNewWorkflow.
	capturedDeepChildWorkflow := initialWorkflow spawnNew.
	capturedStateOfInitialWorkflow := initialWorkflow captureStateForNewTask.
	newDeepChildWorkflow := initialWorkflow spawnNew spawnNew.
	anotherSession := PtyWorkSession new.
	anotherSession addWorkflow: initialWorkflow.
	capturedStateOfInitialWorkflow workSession: anotherSession.
	
	initialWorkflow revertStateTo: capturedStateOfInitialWorkflow.
	
	workSession workflows should include: capturedDeepChildWorkflow.
	workSession workflows should not include: newDeepChildWorkflow
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testSetCurrentTasks [ 
	| anotherWorkflow |
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow registerNewTask: #newTask.
	
	workflow registerNewTask: #existingTask.	
	workflow revertStateTo: anotherWorkflow.
	
	workflow currentTasks should equal: #(newTask).
	workflow currentTasks should not be: anotherWorkflow currentTasks.
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testSetForkedWorkflows [ 
	| anotherWorkflow spawnedWorkflow |
	anotherWorkflow := PtyWorkflow in: workSession.
	spawnedWorkflow := anotherWorkflow spawnNew.
	workflow spawnNew.
	
	workflow revertStateTo: anotherWorkflow.
	
	workflow forkedWorkflows should equal: {spawnedWorkflow}.
	workflow forkedWorkflows should not be: anotherWorkflow forkedWorkflows
]

{ #category : #tests }
PtyWorkflowStateRevertingTest >> testSetParent [ 
	| anotherWorkflow newParentWorkflow |
	newParentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: newParentWorkflow.
	
	workflow revertStateTo: anotherWorkflow.
	
	workflow parentWorkflow should be: newParentWorkflow
]
