Class {
	#name : #PtyUIDevice,
	#superclass : #PtyDevice,
	#instVars : [
		'workSessionsQueue'
	],
	#category : #'Presenty-Devices'
}

{ #category : #controlling }
PtyUIDevice >> attachToWorkplace [
	super attachToWorkplace.
	
	workplace when: PtyWorkSessionEnded send: #newWorkSessionEnded: to: self.
	self startTask: PtyUIUpdateTask new
]

{ #category : #controlling }
PtyUIDevice >> detachFromWorkplace [
	workplace unsubscribe: self.
	
	super detachFromWorkplace
]

{ #category : #initialization }
PtyUIDevice >> initialize [ 
	super initialize.
	
	workSessionsQueue := SharedQueue new
]

{ #category : #controlling }
PtyUIDevice >> newWorkSessionEnded: aWorkSessionEnded [
	self registerWorkSession: aWorkSessionEnded workSession
]

{ #category : #accessing }
PtyUIDevice >> registerWorkSession: aWorkSession [
	workSessionsQueue nextPut: aWorkSession
]

{ #category : #accessing }
PtyUIDevice >> workSessionsQueue [
	^ workSessionsQueue
]

{ #category : #accessing }
PtyUIDevice >> workSessionsQueue: anObject [
	workSessionsQueue := anObject
]
