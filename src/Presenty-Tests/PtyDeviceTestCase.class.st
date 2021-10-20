Class {
	#name : #PtyDeviceTestCase,
	#superclass : #TestCase,
	#instVars : [
		'device',
		'workplace'
	],
	#category : #'Presenty-Tests-Devices'
}

{ #category : #testing }
PtyDeviceTestCase class >> isAbstract [ 
	^self = PtyDeviceTestCase
]

{ #category : #running }
PtyDeviceTestCase >> createDevice [
	self subclassResponsibility 
]

{ #category : #running }
PtyDeviceTestCase >> setUp [
	super setUp.
	
	workplace := Mock new.
	device := self createDevice.
	device workplace: workplace
]

{ #category : #tests }
PtyDeviceTestCase >> testDetachingFromWorkplaceShouldStopAllTasks [

	| task task2 |
	task := Mock new.
	task2 := Mock new.
	device tasks add: task; add: task2.
	
	device detachFromWorkplace.
	
	task should receive stopExecution.
	task2 should receive stopExecution.
	device tasks should be isEmpty
]

{ #category : #tests }
PtyDeviceTestCase >> testHasEmptyTasksByDefault [

	device tasks should be isEmpty
]

{ #category : #tests }
PtyDeviceTestCase >> testStartingTask [

	| task startedTask |
	task := PtyDeviceTask new.
	
	startedTask := device startTask: task.
	
	startedTask should beReturnedFrom: [ workplace planExecutionOf: task ].
	task device should be: device.
	device tasks should include: startedTask.	
	startedTask should receive requestExecution
]
