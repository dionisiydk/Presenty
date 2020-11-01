Class {
	#name : #PtyWorkSessionTest,
	#superclass : #TestCase,
	#instVars : [
		'session',
		'initialWorkflow',
		'workflow'
	],
	#category : #'Presenty-Tests'
}

{ #category : #running }
PtyWorkSessionTest >> setUp [
	super setUp.
	
	initialWorkflow := Mock new.
	workflow := Mock new.
	
	session := PtyWorkSession new.
	session initialWorkflow: initialWorkflow 
]

{ #category : #tests }
PtyWorkSessionTest >> testStopWorkflow [

	session stopWorkflow: workflow.
	
	workflow should receive resumeWorkflow: initialWorkflow
]
