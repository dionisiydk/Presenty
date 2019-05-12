Class {
	#name : #PtyTaskExecutionStrategyTestCase,
	#superclass : #TestCase,
	#instVars : [
		'executionStrategy',
		'worker',
		'task'
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
	executionStrategy := self createStrategy
]
