Class {
	#name : #PtyWorker,
	#superclass : #Object,
	#instVars : [
		'process',
		'workplace'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyWorker class >> atWorkplace: aWorkplace [

	^self new 
		workplace: aWorkplace
]

{ #category : #accessing }
PtyWorker >> defaultTaskExecutionPriority [
	^ workplace defaultTaskExecutionPriority
]

{ #category : #controlling }
PtyWorker >> executeTask: aTask [

	[	
		[aTask body] 
			on: Error do: [:err | workplace notifyUserAbout: err]

	] on: PtyUserRequest do: [:request | 
			request executeBy: workplace].
	
	workplace waitUserAction
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
PtyWorker >> runTask: aTask [
	process := [ self executeTask: aTask ] newProcess.
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
