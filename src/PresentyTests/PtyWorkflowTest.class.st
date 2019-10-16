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
PtyWorkflowTest >> testCreationChildWorkflowForNewTask [ 

	| newWorkflow |
	workflow registerNewTask: #existingTask.
	
	newWorkflow := workflow createNewFor: #newTask.
	
	newWorkflow parentWorkflow should be: workflow.
	newWorkflow currentTasks should include: #newTask.
	newWorkflow currentTasks should include: #existingTask.
	newWorkflow currentTasks should not be: workflow currentTasks
]

{ #category : #tests }
PtyWorkflowTest >> testHasEmptyCurrentTasksByDefault [

	workflow currentTasks should be isEmpty
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
