Class {
	#name : #PtyDevice,
	#superclass : #Object,
	#instVars : [
		'workplace',
		'tasks'
	],
	#category : #'Presenty-Devices'
}

{ #category : #controlling }
PtyDevice >> attachToWorkplace [

]

{ #category : #controlling }
PtyDevice >> detachFromWorkplace [
	tasks do: [ :each | each stopExecution ].
	tasks removeAll
]

{ #category : #initialization }
PtyDevice >> initialize [ 
	super initialize.
	
	tasks := OrderedCollection new
]

{ #category : #controlling }
PtyDevice >> startTask: aDeviceTask [ 
	| plannedTask |
	aDeviceTask device: self.
	plannedTask := workplace planExecutionOf: aDeviceTask.
	
	tasks add: plannedTask.
	plannedTask requestExecution.
	^plannedTask
]

{ #category : #accessing }
PtyDevice >> tasks [
	^ tasks
]

{ #category : #accessing }
PtyDevice >> tasks: anObject [
	tasks := anObject
]

{ #category : #accessing }
PtyDevice >> workplace [
	^ workplace
]

{ #category : #accessing }
PtyDevice >> workplace: anObject [
	workplace := anObject
]
