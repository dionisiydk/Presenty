Class {
	#name : #PtyWorker,
	#superclass : #Object,
	#instVars : [
		'workspace',
		'process'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyWorker class >> at: aWorkspace [

	^self new 
		workspace: aWorkspace
]

{ #category : #accessing }
PtyWorker >> defaultTaskExecutionPriority [
	^ workspace defaultTaskExecutionPriority
]

{ #category : #controlling }
PtyWorker >> executeTask: aTask [

	[	
		[workspace requestUserFor: aTask] 
			on: Error do: [:err | workspace notifyUserAbout: err]

	] on: PtyUserRequest do: [:request | 
			request executeBy: workspace].
	
	workspace waitUserAction
	
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
	process name: 'Execution process of ', aTask printString.
	process priority: self executionPriority.
	process resume
]

{ #category : #controlling }
PtyWorker >> stopTask [
	process ifNotNil: [process terminate]
]

{ #category : #accessing }
PtyWorker >> workspace [
	^ workspace
]

{ #category : #accessing }
PtyWorker >> workspace: anObject [
	workspace := anObject
]
