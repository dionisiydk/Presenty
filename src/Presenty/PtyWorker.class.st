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

{ #category : #'execution API' }
PtyWorker >> executeTask: aTask [

	activeTask := aTask.
	workplace registerActiveTask: aTask.
	
	self isActive ifTrue: [ ^activeTask body].
	
	self startWithTask: aTask
]

{ #category : #testing }
PtyWorker >> isActive [ 
	^process == Processor activeProcess
]

{ #category : #'execution API' }
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

{ #category : #controlling }
PtyWorker >> runInitialTask: aTask [

	[	
		[aTask body] 
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

{ #category : #'execution API' }
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
