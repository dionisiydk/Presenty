Class {
	#name : #PtyWorkSessionTest,
	#superclass : #TestCase,
	#instVars : [
		'workSession'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkSessionTest >> setUp [
	super setUp.
	
	workSession := PtyWorkSession new
]

{ #category : #tests }
PtyWorkSessionTest >> testCurrentTasks [

	| workflow1 workflow2 allTasks |
	workflow1 := PtyWorkflow new.
	workflow1 registerNewTask: #task1.
	workflow2 := PtyWorkflow new.
	workflow2 registerNewTask: #task2.
	workSession addWorkflow: workflow1; addWorkflow: workflow2.
	
	allTasks := workSession currentTasks.
	
	allTasks should equal: #(task1 task2)
]

{ #category : #tests }
PtyWorkSessionTest >> testFindingWorkflowWithGivenTask [

	| someWorkflow targetWorkflow found |
	someWorkflow := PtyWorkflow new.
	someWorkflow registerNewTask: #someOtherTask.
	targetWorkflow := PtyWorkflow new.
	targetWorkflow registerNewTask: #task.
	workSession addWorkflow: someWorkflow; addWorkflow: targetWorkflow.
	
	found := workSession workflowWith: #task.
	
	found should be: targetWorkflow
]

{ #category : #tests }
PtyWorkSessionTest >> testHasEmptyWorkflowsByDefault [

	workSession workflows should be isEmpty
]

{ #category : #tests }
PtyWorkSessionTest >> testNewWorkflowAddition [

	| workflow |
	workflow := workSession addNewWorkflow.
	
	workflow should beInstanceOf: PtyWorkflow.
	workflow workSession should be: workSession
]

{ #category : #tests }
PtyWorkSessionTest >> testSpawnNewSession [ 

	| newSession workflow |
	workflow := workSession addNewWorkflow.
	workflow registerNewTask: PtyTask new.
	
	newSession := workSession spawnNew.
	
	newSession parentSession should be: workSession.
	newSession workflows should equal: workSession workflows.
	newSession workflows should not be: workSession workflows
]
