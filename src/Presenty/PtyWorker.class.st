Class {
	#name : #PtyWorker,
	#superclass : #Object,
	#instVars : [
		'workplace',
		'process',
		'activeTask'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyWorker class >> atWorkplace: aWorkplace [

	^self new 
		workplace: aWorkplace
]

{ #category : #accessing }
PtyWorker >> activeTask [
	^ activeTask
]

{ #category : #accessing }
PtyWorker >> activeTask: anObject [
	activeTask := anObject
]

{ #category : #accessing }
PtyWorker >> defaultTaskExecutionPriority [
	^ workplace defaultTaskExecutionPriority
]

{ #category : #controlling }
PtyWorker >> executeInitialTask: aTask [

	[	
		[aTask body] 
			on: Error do: [:err | workplace notifyUserAbout: err]

	] on: PtyUserRequest do: [:request | 
			request executeBy: workplace].
	
	workplace waitUserAction
]

{ #category : #controlling }
PtyWorker >> executeTask: aTask [

	activeTask := aTask.
	self isActive ifTrue: [ ^activeTask body].
	
	self startWithTask: aTask
]

{ #category : #accessing }
PtyWorker >> process [
	^ process
]

{ #category : #accessing }
PtyWorker >> process: anObject [
	process := anObject
]

{ #category : #controlling }
PtyWorker >> startWithTask: aTask [
	process := [ self executeInitialTask: aTask ] newProcess.
	process name: 'Worker process of ', aTask printString.
	process priority: aTask executionPriority.
	process resume
]

{ #category : #controlling }
PtyWorker >> stopTask [
	process ifNotNil: [process terminate]
]

{ #category : #accessing }
PtyWorker >> workplace [
	^ workplace
]

{ #category : #accessing }
PtyWorker >> workplace: anObject [
	workplace := anObject
]
