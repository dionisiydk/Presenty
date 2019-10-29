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
PtyWorkSessionTest >> testFindingActiveWorkflowWhenItNotExist [

	[session findActiveWorkflowSpawned: PtyWorkflow new captureStateForNewTask] should fail
]

{ #category : #tests }
PtyWorkSessionTest >> testFindingActiveWorkflowWhichJustSpawnedGivenOne [

	| someWorkflow targetWorkflow found |
	someWorkflow := PtyWorkflow new.
	someWorkflow registerNewTask: #someOtherTask.
	targetWorkflow := PtyWorkflow new.
	targetWorkflow registerNewTask: #task.
	session addWorkflow: someWorkflow; addWorkflow: targetWorkflow.
	
	found := session findActiveWorkflowSpawned: targetWorkflow captureStateForNewTask.
	
	found should be: targetWorkflow
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
PtyWorkSessionTest >> testRegisteringNewTask [ 

	| workflow task |
	workflow := session addNewWorkflow.
	task := PtyTask new.
	task initialWorkflow: workflow captureStateForNewTask.
	
	session registerNewTask: task.
	
	workflow currentTasks should include: task
]

{ #category : #tests }
PtyWorkSessionTest >> testRegisteringNewTaskWithUnknownWorkflow [

	| task unknownWorkflow |
	unknownWorkflow := PtyWorkflow new.
	task := PtyTask new.
	task initialWorkflow: unknownWorkflow captureStateForNewTask.
	
	[session registerNewTask: task] should fail.

	unknownWorkflow currentTasks should be isEmpty
]

{ #category : #tests }
PtyWorkSessionTest >> testRemoveTask [ 

	| workflow task |
	workflow := session addNewWorkflow.
	task := PtyTask new.
	task initialWorkflow: workflow captureStateForNewTask.
	workflow registerNewTask: task.
	
	session removeTask: task.
	
	workflow currentTasks should not include: task
]

{ #category : #tests }
PtyWorkSessionTest >> testSpawnNewSessionWithNewTask [ 

	| newSession workflow newTask |
	workflow := session addNewWorkflow.
	newTask := PtyTask new.
	newTask initialWorkflow: workflow captureStateForNewTask.
	
	newSession := session spawnWithNewTask: newTask.
	
	newSession parentSession should be: session.
	newSession workflows should equal: session workflows.
	newSession workflows should not be: session workflows.
	workflow currentTasks should include: newTask
]
