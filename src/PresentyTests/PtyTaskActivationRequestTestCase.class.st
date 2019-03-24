Class {
	#name : #PtyTaskActivationRequestTestCase,
	#superclass : #TestCase,
	#instVars : [
		'request',
		'task',
		'taskContext'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #testing }
PtyTaskActivationRequestTestCase class >> isAbstract [ 
	^self == PtyTaskActivationRequestTestCase 
]

{ #category : #running }
PtyTaskActivationRequestTestCase >> requestClass [
	self subclassResponsibility 
]

{ #category : #running }
PtyTaskActivationRequestTestCase >> setUp [
	super setUp.
	
	task := Mock new.
	taskContext := Mock new.
	request := self requestClass for: task.

]
