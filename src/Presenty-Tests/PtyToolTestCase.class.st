Class {
	#name : #PtyToolTestCase,
	#superclass : #TestCase,
	#instVars : [
		'tool',
		'panel',
		'targetTask'
	],
	#category : #'Presenty-Tests-Tools'
}

{ #category : #testing }
PtyToolTestCase class >> isAbstract [ 
	^self = PtyToolTestCase
]

{ #category : #running }
PtyToolTestCase >> createTool [
	self subclassResponsibility 
]

{ #category : #running }
PtyToolTestCase >> setUp [ 
	super setUp.
	
	panel := Mock new.
	targetTask := Mock new.
	tool := self createTool.
	tool targetTask: targetTask.
	tool panel: panel
]

{ #category : #tests }
PtyToolTestCase >> testAttachToPanel [

	panel := Mock new.
	targetTask stub controlPanel willReturn: panel.
	
	tool attachToPanel.
	
	tool panel should be: panel.
	panel should receive addTool: tool.
]

{ #category : #tests }
PtyToolTestCase >> testDetachFromPanel [

	tool detachFromPanel.
	
	tool panel should be: nil.
	panel should receive removeTool: tool
]
