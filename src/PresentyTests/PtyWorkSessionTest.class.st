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
PtyWorkSessionTest >> testHasEmptyWorkflowsByDefault [

	session workflows should be isEmpty
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
