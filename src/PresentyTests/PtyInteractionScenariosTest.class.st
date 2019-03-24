Class {
	#name : #PtyInteractionScenariosTest,
	#superclass : #TestCase,
	#instVars : [
		'workspace'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyInteractionScenariosTest >> setUp [
	super setUp.
	
	workspace := PtyWorkspace new.
]

{ #category : #tests }
PtyInteractionScenariosTest >> testSingleTask [ 

	| task |
	task := [ #result ] asTask.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }
]
