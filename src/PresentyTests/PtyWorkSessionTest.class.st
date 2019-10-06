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
	session registerActiveTask: #existingTask.
	
	newSession := session createNewFor: #newTask.
	
	newSession parentSession should be: session.
	newSession activeTasks should include: #newTask.
	newSession activeTasks should include: #existingTask.
	newSession activeTasks should not be: session activeTasks
]

{ #category : #tests }
PtyWorkSessionTest >> testHasEmptyActiveTasksByDefault [

	session activeTasks should be isEmpty
]

{ #category : #tests }
PtyWorkSessionTest >> testRegisteringActiveTask [ 

	session registerActiveTask: #task.
	
	session activeTasks should include: #task
]

{ #category : #tests }
PtyWorkSessionTest >> testRemoveTask [ 

	session registerActiveTask: #task.
	
	session removeTask: #task.
	
	session activeTasks should not include: #task
]
