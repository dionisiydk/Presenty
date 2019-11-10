Class {
	#name : #PtyWorkflowTest,
	#superclass : #TestCase,
	#instVars : [
		'workflow'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkflowTest >> setUp [
	super setUp.
	
	workflow := PtyWorkflow new
]

{ #category : #tests }
PtyWorkflowTest >> testActivationShouldAlsoActivatesParent [ 
	| parentWorkflow anotherWorkflow |
	parentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: parentWorkflow.
	workflow parentWorkflow: parentWorkflow.
	
	workflow activateAs: anotherWorkflow.
	
	parentWorkflow should receive activateWithSpawnedWorkflow: workflow.
]

{ #category : #tests }
PtyWorkflowTest >> testActivationShouldCleanExistingParent [ 
	| anotherWorkflow newParentWorkflow existingParent |
	newParentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: newParentWorkflow.
	existingParent := Mock new.
	workflow parentWorkflow: existingParent.
	
	workflow activateAs: anotherWorkflow.
	
	existingParent should receive removeSpawnedWorkflow: workflow.
	workflow parentWorkflow should be: newParentWorkflow.
]

{ #category : #tests }
PtyWorkflowTest >> testActivationShouldSetNewCurrentTasks [ 
	| anotherWorkflow |
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow registerNewTask: #newTask.
	
	workflow registerNewTask: #existingTask.	
	workflow activateAs: anotherWorkflow.
	
	workflow currentTasks should equal: #(newTask).
	workflow currentTasks should not be: anotherWorkflow currentTasks.
]

{ #category : #tests }
PtyWorkflowTest >> testActivationShouldSetNewParent [ 
	| anotherWorkflow newParentWorkflow |
	newParentWorkflow := Mock new.
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow parentWorkflow: newParentWorkflow.
	
	workflow activateAs: anotherWorkflow.
	
	workflow parentWorkflow should be: newParentWorkflow
]

{ #category : #tests }
PtyWorkflowTest >> testActivationShouldSetNewSpawnedWorkflows [ 
	| anotherWorkflow spawnedWorkflow |
	anotherWorkflow := PtyWorkflow new.
	spawnedWorkflow := anotherWorkflow spawnNew.
	workflow spawnNew.
	
	workflow activateAs: anotherWorkflow.
	
	workflow spawnedWorkflows should equal: {spawnedWorkflow}.
	workflow spawnedWorkflows should not be: anotherWorkflow spawnedWorkflows
]

{ #category : #tests }
PtyWorkflowTest >> testActivationWithGivenSpawnedWorkflow [ 

	| newWorkflow parentWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	newWorkflow := PtyWorkflow new.
	
	workflow activateWithSpawnedWorkflow: newWorkflow.
	
	workflow spawnedWorkflows should include: newWorkflow.
	parentWorkflow should receive activateWithSpawnedWorkflow: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testActivationWithGivenSpawnedWorkflowWhenItIsAlreadyActivated [

	| newWorkflow parentWorkflow |
	parentWorkflow := Mock new.
	workflow parentWorkflow: parentWorkflow.
	newWorkflow := workflow spawnNew.
	
	workflow activateWithSpawnedWorkflow: newWorkflow.
	
	workflow spawnedWorkflows should haveSize: 1.
	parentWorkflow should receive activateWithSpawnedWorkflow: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testActivationWithGivenSpawnedWorkflowWhenNoParentExists [

	| newWorkflow |
	workflow parentWorkflow: nil.
	newWorkflow := PtyWorkflow new.
	
	workflow activateWithSpawnedWorkflow: newWorkflow.
	
	workflow spawnedWorkflows should include: newWorkflow
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
PtyWorkflowTest >> testCaptureStateForNewTask [ 

	| capturedWorkflow |
	workflow registerNewTask: #existingTask.
	
	capturedWorkflow := workflow captureStateForNewTask.
	
	capturedWorkflow currentTasks should include: #existingTask.
	capturedWorkflow currentTasks should not be: workflow currentTasks
]

{ #category : #tests }
PtyWorkflowTest >> testCaptureStateForNewTaskShouldCopySpawnedWorkflowsList [

	| capturedWorkflow forkedWorkflow |
	forkedWorkflow := workflow spawnNew.
	
	capturedWorkflow := workflow captureStateForNewTask.
	
	capturedWorkflow spawnedWorkflows should include: forkedWorkflow.
	capturedWorkflow spawnedWorkflows should not be: workflow spawnedWorkflows
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
PtyWorkflowTest >> testSpawnNewWorkflow [ 

	| newWorkflow |
	workflow registerNewTask: #existingTask.
	
	newWorkflow := workflow spawnNew.
	
	newWorkflow parentWorkflow should be: workflow.
	workflow spawnedWorkflows should include: newWorkflow.
	newWorkflow currentTasks should be isEmpty.
	newWorkflow currentTasks should not be: workflow currentTasks
]
