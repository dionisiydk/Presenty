Class {
	#name : #PtyTaskController,
	#superclass : #Object,
	#instVars : [
		'guide',
		'process'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTaskController class >> of: aGuide [

	^self new guide: aGuide 
]

{ #category : #controlling }
PtyTaskController >> executeTask: aTask [

	[	
		[guide requestUserFor: aTask] 
			on: Error do: [:err | guide notifyUserAbout: err]

	] on: PtyUserRequest do: [:request | 
			request executeBy: guide].
	
	guide waitUserAction
	
]

{ #category : #accessing }
PtyTaskController >> guide [
	^ guide
]

{ #category : #accessing }
PtyTaskController >> guide: anObject [
	guide := anObject
]

{ #category : #accessing }
PtyTaskController >> process [
	^ process
]

{ #category : #accessing }
PtyTaskController >> process: anObject [
	process := anObject
]

{ #category : #controlling }
PtyTaskController >> runTask: aTask [
	process := [ self executeTask: aTask ] newProcess.
	process name: 'Execution process of ', aTask printString.
	process priority: Processor userSchedulingPriority + 1.
	process resume
]

{ #category : #controlling }
PtyTaskController >> stopTask [
	process ifNotNil: [process terminate]
]
