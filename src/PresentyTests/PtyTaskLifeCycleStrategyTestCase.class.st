Class {
	#name : #PtyTaskLifeCycleStrategyTestCase,
	#superclass : #TestCase,
	#instVars : [
		'worker',
		'task',
		'workflow',
		'strategy'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #testing }
PtyTaskLifeCycleStrategyTestCase class >> isAbstract [ 
	^self = PtyTaskLifeCycleStrategyTestCase 
]

{ #category : #running }
PtyTaskLifeCycleStrategyTestCase >> createStrategy [
	self subclassResponsibility 
]

{ #category : #running }
PtyTaskLifeCycleStrategyTestCase >> setUp [
	super setUp.
	task := Mock new.
	worker := Mock new.
	workflow := Mock new.
	strategy := self createStrategy
]
