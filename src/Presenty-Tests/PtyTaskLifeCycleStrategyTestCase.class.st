Class {
	#name : #PtyTaskLifeCycleStrategyTestCase,
	#superclass : #TestCase,
	#instVars : [
		'task',
		'strategy',
		'workflow'
	],
	#category : #'Presenty-Tests'
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
	workflow := Mock new.
	strategy := self createStrategy
]
