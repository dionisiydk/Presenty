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

{ #category : #controlling }
PtyWorker >> continueWithTask: aTask [
	
	| executionStage |
	executionStage := aTask currentExecutionStage.
	
	^executionStage continueExecution
]

{ #category : #accessing }
PtyWorker >> defaultTaskExecutionPriority [
	^ workplace defaultTaskExecutionPriority
]

{ #category : #'task execution' }
PtyWorker >> deferTask: aTask [
	
	workplace registerActiveTask: aTask
]

{ #category : #'task execution' }
PtyWorker >> executeTask: aTask [

	activeTask := aTask.
	workplace registerActiveTask: aTask.
	
	self isActive ifTrue: [ ^self continueWithTask: aTask].
	
	self startWithTask: aTask
]

{ #category : #testing }
PtyWorker >> isActive [ 
	^process == Processor activeProcess
]

{ #category : #'task execution' }
PtyWorker >> notifyUserAbout: anError [
]

{ #category : #accessing }
PtyWorker >> process [
	^ process
]

{ #category : #accessing }
PtyWorker >> process: anObject [
	process := anObject
]

{ #category : #'task execution' }
PtyWorker >> removeTask: aTask [
	
	workplace removeTask: aTask
]

{ #category : #controlling }
PtyWorker >> runInitialTask: aTask [

	[	
		[aTask startExecution] 
			on: Error do: [:err | self notifyUserAbout: err]

	] on: PtyUserRequest do: [:request | 
			request executeBy: self].
	
	self waitUserAction
]

{ #category : #controlling }
PtyWorker >> startWithTask: aTask [
	process := [ self runInitialTask: aTask ] newProcess.
	process name: 'Worker process of ', aTask printString.
	process priority: aTask executionPriority.
	process resume
]

{ #category : #controlling }
PtyWorker >> stopTask [
	process ifNotNil: [process terminate]
]

{ #category : #'task execution' }
PtyWorker >> waitUserAction [
]

{ #category : #accessing }
PtyWorker >> workplace [
	^ workplace
]

{ #category : #accessing }
PtyWorker >> workplace: anObject [
	workplace := anObject
]
