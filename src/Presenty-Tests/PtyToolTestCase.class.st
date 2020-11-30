Class {
	#name : #PtyToolTestCase,
	#superclass : #TestCase,
	#instVars : [
		'tool',
		'panel'
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
	tool := self createTool.
	tool assignToPanel: panel
]
