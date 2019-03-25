Class {
	#name : #PtyWorkspaceTestCase,
	#superclass : #TestCase,
	#instVars : [
		'workspace'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #testing }
PtyWorkspaceTestCase class >> isAbstract [ 
	^self = PtyWorkspaceTestCase 
]

{ #category : #running }
PtyWorkspaceTestCase >> setUp [
	super setUp.
	
	workspace := PtyWorkspace new.
]
