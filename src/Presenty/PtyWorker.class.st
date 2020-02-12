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
PtyWorker >> activeTask: aTask [
	activeTask := aTask
]

{ #category : #controlling }
PtyWorker >> continueWithTask: aTask [
	
	^self continueWithTask: aTask using: (PtyTaskStartStage of: aTask)
]

{ #category : #controlling }
PtyWorker >> continueWithTask: aTask using: initialTaskExecutionStage [
	
	| executionStage result |
	executionStage := aTask currentExecutionStageStartedWith: initialTaskExecutionStage.	
	
	activeTask := aTask.
	result := executionStage continueExecution.
	activeTask := aTask parentTask.
	
	^result
]

{ #category : #'task execution' }
PtyWorker >> deferTask: aTask [

	aTask beActiveInWorkflow.
	
	self isActive ifTrue: [ 
		^self continueWithTask: aTask using: (PtyTaskDefermentStage of: aTask)].
	
	^PtyTaskExecutionFutureResult of: aTask
]

{ #category : #'task execution' }
PtyWorker >> deliverResult: anObject of: aTask [

	self isActive ifTrue: [ ^aTask jumpToResultDeliveryStageWith: anObject ].
	
	self startWithTask: (PtyDeliverResultTask result: anObject from: aTask)
]

{ #category : #'task execution' }
PtyWorker >> executeTask: aTask [
	
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
PtyWorker >> retryTask: aTask [

	self isActive ifTrue: [ ^aTask jumpToRetryStage].
	
	self startWithTask: (PtyRetryTask for: aTask)
]

{ #category : #controlling }
PtyWorker >> runInitialTask: aTask [

	[	
		[self continueWithTask: aTask] 
			on: Error do: [:err | self notifyUserAbout: err]

	] on: PtyUserRequest do: [:request | 
			request executeBy: self].
	
	self waitUserAction
]

{ #category : #controlling }
PtyWorker >> startWithTask: aTask [
	workplace registerWorker: self.
	
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
