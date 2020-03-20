Class {
	#name : #PtyWorkflowStageTestCase,
	#superclass : #TestCase,
	#instVars : [
		'workflowStage',
		'task',
		'worker'
	],
	#category : #'Presenty-Tests'
}

{ #category : #testing }
PtyWorkflowStageTestCase class >> isAbstract [
	^self = PtyWorkflowStageTestCase
]

{ #category : #running }
PtyWorkflowStageTestCase >> createWorkflowStage [
	self subclassResponsibility 
]

{ #category : #running }
PtyWorkflowStageTestCase >> setUp [
	super setUp.
	
	worker := Mock new.
	task := Mock new.
	workflowStage := self createWorkflowStage
]
