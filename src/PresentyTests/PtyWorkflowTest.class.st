Class {
	#name : #PtyWorkflowTest,
	#superclass : #TestCase,
	#instVars : [
		'workflow',
		'workSession'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkflowTest >> setUp [
	super setUp.
	
	workSession := Mock new.
	workflow := PtyWorkflow in: workSession
]

{ #category : #tests }
PtyWorkflowTest >> testCaptureStateForNewTask [ 

	| capturedWorkflow |
	workflow registerNewTask: #existingTask.
	
	capturedWorkflow := workflow captureStateForNewTask.
	
	capturedWorkflow workSession should be: workSession.
	capturedWorkflow currentTasks should include: #existingTask.
	capturedWorkflow currentTasks should not be: workflow currentTasks
]

{ #category : #tests }
PtyWorkflowTest >> testCaptureStateForNewTaskShouldCopyForkedWorkflowsList [

	| capturedWorkflow forkedWorkflow |
	forkedWorkflow := workflow spawnNew.
	
	capturedWorkflow := workflow captureStateForNewTask.
	
	capturedWorkflow forkedWorkflows should include: forkedWorkflow.
	capturedWorkflow forkedWorkflows should not be: workflow forkedWorkflows
]

{ #category : #tests }
PtyWorkflowTest >> testHasEmptyCurrentTasksByDefault [

	workflow currentTasks should be isEmpty
]

{ #category : #tests }
PtyWorkflowTest >> testHasEmptyForkedWorkflowsByDefault [

	workflow forkedWorkflows should be isEmpty
]

{ #category : #tests }
PtyWorkflowTest >> testIncludesTask [

	workflow should not be includesTask: #someTask.
	
	workflow registerNewTask: #existingTask.
	
	workflow should be includesTask: #existingTask.
]

{ #category : #tests }
PtyWorkflowTest >> testRegisteringNewTask [ 

	workflow registerNewTask: #task.
	
	workflow currentTasks should include: #task
]

{ #category : #tests }
PtyWorkflowTest >> testRemoveTask [ 

	workflow registerNewTask: #task.
	
	workflow removeTask: #task.
	
	workflow currentTasks should not include: #task
]

{ #category : #tests }
PtyWorkflowTest >> testRevertingStateShouldAlsoRevertStateOfWorkSession [

	| anotherWorkflow |
	anotherWorkflow := PtyWorkflow in: #anotherSession.
		
	workflow revertStateTo: anotherWorkflow.
	
	workSession should receive revertStateTo: #anotherSession startingAt: workflow
]

{ #category : #tests }
PtyWorkflowTest >> testRevertingStateShouldResetCurrentTasks [ 
	| anotherWorkflow |
	anotherWorkflow := PtyWorkflow new.
	anotherWorkflow registerNewTask: #newTask.
	workflow registerNewTask: #existingTask.
	
	workflow revertStateTo: anotherWorkflow.
	
	workflow currentTasks should equal: #(newTask).
	workflow currentTasks should not be: anotherWorkflow currentTasks.
]

{ #category : #tests }
PtyWorkflowTest >> testSpawnNewWorkflow [ 

	| newWorkflow |
	workflow registerNewTask: #existingTask.
	
	newWorkflow := workflow spawnNew.
	
	newWorkflow workSession should be: workSession.
	workSession should receive addWorkflow: newWorkflow.
	newWorkflow parentWorkflow should be: workflow.
	workflow forkedWorkflows should include: newWorkflow.
	newWorkflow currentTasks should be isEmpty.
	newWorkflow currentTasks should not be: workflow currentTasks
]
