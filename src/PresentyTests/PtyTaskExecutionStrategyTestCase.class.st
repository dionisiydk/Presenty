Class {
	#name : #PtyTaskExecutionStrategyTestCase,
	#superclass : #TestCase,
	#instVars : [
		'executionStrategy',
		'worker',
		'task',
		'workflow'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #testing }
PtyTaskExecutionStrategyTestCase class >> isAbstract [ 
	^self = PtyTaskExecutionStrategyTestCase 
]

{ #category : #running }
PtyTaskExecutionStrategyTestCase >> createStrategy [
	self subclassResponsibility 
]

{ #category : #running }
PtyTaskExecutionStrategyTestCase >> setUp [
	super setUp.
	task := Mock new.
	worker := Mock new.
	workflow := Mock new.
	executionStrategy := self createStrategy
]

{ #category : #tests }
PtyTaskExecutionStrategyTestCase >> testShouldRegisterTaskItselfInExecutionWorkflow [
	
	executionStrategy prepareWorkflow: workflow forExecutionOf: #task.
	
	workflow should receive registerNewTask: #task
]
