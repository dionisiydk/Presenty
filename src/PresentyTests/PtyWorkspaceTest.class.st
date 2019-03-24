Class {
	#name : #PtyWorkspaceTest,
	#superclass : #TestCase,
	#instVars : [
		'workspace'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyWorkspaceTest >> setUp [
	super setUp.
	
	workspace := PtyWorkspace new.
]

{ #category : #tests }
PtyWorkspaceTest >> testHasNoActiveTasksByDefault [

	workspace activeTasks should be isEmpty
]
