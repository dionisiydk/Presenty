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
PtyWorkflowTest >> testCaptureStateForNewTask [ 

	| newWorkflow |
	workflow registerNewTask: #existingTask.
	workflow workSession: #session.
	workflow parentWorkflow: #parentWorkflow.
	
	newWorkflow := workflow captureStateForNewTask.
	
	newWorkflow parentWorkflow should be: #parentWorkflow.
	newWorkflow workSession should be: #session.
	newWorkflow currentTasks should include: #existingTask.
	newWorkflow currentTasks should not be: workflow currentTasks
]

{ #category : #tests }
PtyWorkflowTest >> testHasEmptyCurrentTasksByDefault [

	workflow currentTasks should be isEmpty
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
