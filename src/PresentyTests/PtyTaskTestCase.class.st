Class {
	#name : #PtyTaskTestCase,
	#superclass : #TestCase,
	#instVars : [
		'task',
		'guide',
		'user',
		'parentContext'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #testing }
PtyTaskTestCase class >> isAbstract [ 
	^self = PtyTaskTestCase 
]

{ #category : #running }
PtyTaskTestCase >> setUp [
	super setUp.
	
	parentContext := Mock new.
	guide := Mock new.
	user := Mock new.
	task := self taskClass new.
	task guide: guide.
	task user: user.
	task context: parentContext
]

{ #category : #running }
PtyTaskTestCase >> taskClass [
	self subclassResponsibility 
]

{ #category : #tests }
PtyTaskTestCase >> testBecomeDefferedTask [

	| executionStrategy |
	executionStrategy := task beDeferred.

	task executionStrategy should be: executionStrategy.
	executionStrategy should beInstanceOf: PtyDeferredTaskExecution
]

{ #category : #tests }
PtyTaskTestCase >> testBecomeImmediateTask [

	| executionStrategy |
	executionStrategy := task beImmediate.

	task executionStrategy should be: executionStrategy.
	executionStrategy should beInstanceOf: PtyImmediateTaskExecution
]

{ #category : #tests }
PtyTaskTestCase >> testBecomeOneShotTask [

	| executionStrategy |
	executionStrategy := task beOneShot.

	task executionStrategy should be: executionStrategy.
	executionStrategy should beInstanceOf: PtyOneShotTaskExecution
]

{ #category : #tests }
PtyTaskTestCase >> testBecomeRequestedForUser [

	| worker |
	worker := Mock new.
	
	task beRequestedFor: #user from: worker.

	task user should be: #user.
	task worker should be: worker.
	task parentTask should beReturnedFrom: [ worker activeTask ] 
]

{ #category : #tests }
PtyTaskTestCase >> testExecution [

	| executionStrategy result |
	executionStrategy := Mock new.
	task worker: #worker.
	task executionStrategy: executionStrategy.

	result := task requestExecution.

	result should beReturnedFrom: [ executionStrategy execute: task using: #worker ]
]

{ #category : #tests }
PtyTaskTestCase >> testHasDefaultExecutionStrategy [

	task executionStrategy should equals: task defaultExecutionStrategy
]

{ #category : #tests }
PtyTaskTestCase >> testKindOfSameTask [

	| actual |
	actual := task isKindOfTask: self taskClass new.
	
	actual should be: true
]

{ #category : #tests }
PtyTaskTestCase >> testKindOfSuperclassTask [

	| actual |
	actual := task isKindOfTask: PtyTask new.
	
	actual should be: true
]

{ #category : #tests }
PtyTaskTestCase >> testKindOfSuperclassTaskWithEqualName [

	| actual |
	task name: 'test name'.

	actual := task isKindOfTask: (PtyTask named: 'test name' copy).
	
	actual should be: true
]

{ #category : #tests }
PtyTaskTestCase >> testNotKindOfClassWhenItsNotSuperclass [

	| actual |

	actual := task isKindOfTask: PtyTaskStub new.
	
	actual should be: false
]

{ #category : #tests }
PtyTaskTestCase >> testNotKindOfSuperclassTaskWhenItHasDifferentName [

	| actual |
	task name: 'test name'.

	actual := task isKindOfTask: (PtyTask named: 'different name').
	
	actual should be: false
]

{ #category : #tests }
PtyTaskTestCase >> testNotSimilarToTaskOfDifferentClass [

	| actual |

	actual := task isSimilarTo: Object new.
	
	actual should be: false
]

{ #category : #tests }
PtyTaskTestCase >> testNotSimilarToTaskOfSameClassButWithDifferentName [

	| actual |
	task name: 'test name'.

	actual := task isSimilarTo: (self taskClass named: 'different name').
	
	actual should be: false
]

{ #category : #tests }
PtyTaskTestCase >> testSimilarToTaskOfSameClass [

	| actual |
	actual := task isSimilarTo: self taskClass new.
	
	actual should be: true
]

{ #category : #tests }
PtyTaskTestCase >> testSimilarToTaskWithEqualName [

	| actual |
	task name: 'test name'.

	actual := task isSimilarTo: (self taskClass named: 'test name' copy).
	
	actual should be: true
]
