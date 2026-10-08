Class {
	#name : #PtyWorkflowStageTestCase,
	#superclass : #TestCase,
	#instVars : [
		'workflowStage',
		'task',
		'worker'
	],
	#category : #'Presenty-Tests-Tasks'
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

{ #category : #tests }
PtyWorkflowStageTestCase >> testExecutionPriority [

	workflowStage executionPriority should beReturnedFrom: [ task executionPriority ]
]

{ #category : #tests }
PtyWorkflowStageTestCase >> testWorkflow [

	workflowStage workflow should beReturnedFrom: [ task workflow ]
]
