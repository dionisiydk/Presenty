Class {
	#name : #PtyWorkspaceTest,
	#superclass : #PtyWorkspaceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyWorkspaceTest >> testHasNoActiveTasksByDefault [

	workspace activeTasks should be isEmpty
]
