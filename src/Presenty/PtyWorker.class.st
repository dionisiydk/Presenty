Class {
	#name : #PtyWorker,
	#superclass : #Object,
	#instVars : [
		'workplace',
		'process',
		'currentTask'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyWorker class >> atWorkplace: aWorkplace [

	^self new 
		workplace: aWorkplace
]

{ #category : #'task execution' }
PtyWorker >> captureInitialWorkflowFor: aTask [

	^workplace captureInitialWorkflowFor: aTask
]

{ #category : #controlling }
PtyWorker >> continueWithTask: aTask [
	
	| executionStage |
	executionStage := aTask currentExecutionStage.
	
	^executionStage continueExecution
]

{ #category : #accessing }
PtyWorker >> currentTask [
	^ currentTask
]

{ #category : #accessing }
PtyWorker >> currentTask: anObject [
	currentTask := anObject
]

{ #category : #accessing }
PtyWorker >> defaultTaskExecutionPriority [
	^ workplace defaultTaskExecutionPriority
]

{ #category : #'task execution' }
PtyWorker >> deferTask: aTask [
	
	workplace registerNewTask: aTask.
	^PtyTaskExecutionFutureResult of: aTask
]

{ #category : #'task execution' }
PtyWorker >> deliverResult: anObject of: aTask [

	self isActive ifTrue: [ ^aTask completeExecutionWith: anObject ].
	
	self startWithTask: (PtyDeliverResultTask result: anObject from: aTask)
]

{ #category : #'task execution' }
PtyWorker >> executeTask: aTask [

	currentTask := aTask.
	
	self isActive ifTrue: [ ^self continueWithTask: aTask].
	
	self startWithTask: aTask.
	^PtyTaskExecutionFutureResult of: aTask
]

{ #category : #testing }
PtyWorker >> isActive [ 
	^process == Processor activeProcess
]

{ #category : #'task execution' }
PtyWorker >> notifyUserAbout: anError [

	^anError pass
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
	workplace startWorkSessionBy: self.
	
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
