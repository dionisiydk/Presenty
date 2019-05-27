Class {
	#name : #PtyTaskExecutionStageTestCase,
	#superclass : #TestCase,
	#instVars : [
		'executionStage',
		'task'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #testing }
PtyTaskExecutionStageTestCase class >> isAbstract [
	^self = PtyTaskExecutionStageTestCase
]

{ #category : #running }
PtyTaskExecutionStageTestCase >> createExecutionStage [
	self subclassResponsibility 
]

{ #category : #running }
PtyTaskExecutionStageTestCase >> setUp [
	super setUp.
	
	task := Mock new.
	executionStage := self createExecutionStage
]
