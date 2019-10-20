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
PtyWorkSessionTest >> testCapturingInitialWorkflowForInitialTask [

	| newWorkflow capturedWorkflow |
	
	capturedWorkflow := session captureInitialWorkflowFor: PtyTask new.
	
	session workflows should haveSize: 1. 
	newWorkflow := session workflows first.
	newWorkflow workSession should be: session.
	capturedWorkflow should not be: newWorkflow.
	capturedWorkflow parentWorkflow should be: newWorkflow.
	capturedWorkflow currentTasks should not be: newWorkflow currentTasks
]

{ #category : #tests }
PtyWorkSessionTest >> testCapturingInitialWorkflowForTask [

	| someWorkflow targetWorkflow newWorkflow task |
	task := PtyTask new.
	task parentTask: #parentTask.
	someWorkflow := PtyWorkflow new.
	someWorkflow registerNewTask: #someOtherTask.
	targetWorkflow := PtyWorkflow new.
	targetWorkflow registerNewTask: #parentTask.
	session addWorkflow: someWorkflow; addWorkflow: targetWorkflow.
	
	newWorkflow := session captureInitialWorkflowFor: task.
	
	newWorkflow should not be: targetWorkflow.
	newWorkflow parentWorkflow should be: targetWorkflow.
	newWorkflow currentTasks should equal: targetWorkflow currentTasks.
	newWorkflow currentTasks should not be: targetWorkflow currentTasks.
	newWorkflow workSession should be: targetWorkflow workSession.
]

{ #category : #tests }
PtyWorkSessionTest >> testCapturingInitialWorkflowForTaskWithUnknownParentTask [

	| task |
	task := PtyTask new.
	task parentTask: #parentTask.
	
	[session captureInitialWorkflowFor: task] should raise: NotFound
]

{ #category : #tests }
PtyWorkSessionTest >> testCreationChildSessionForNewTask [ 

	| newSession |
	session registerNewTask: #existingTask.
	
	newSession := session createNewFor: #newTask.
	
	newSession parentSession should be: session.
	newSession currentTasks should include: #newTask.
	newSession currentTasks should include: #existingTask.
	newSession currentTasks should not be: session currentTasks
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

	session registerNewTask: #task.
	
	session currentTasks should include: #task
]

{ #category : #tests }
PtyWorkSessionTest >> testRemoveTask [ 

	session registerNewTask: #task.
	
	session removeTask: #task.
	
	session currentTasks should not include: #task
]
