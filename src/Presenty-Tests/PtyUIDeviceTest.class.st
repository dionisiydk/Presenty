Class {
	#name : #PtyUIDeviceTest,
	#superclass : #PtyDeviceTestCase,
	#category : #'Presenty-Tests-Devices'
}

{ #category : #running }
PtyUIDeviceTest >> createDevice [
	^PtyUIDevice new
]

{ #category : #tests }
PtyUIDeviceTest >> testHasEmptyWorkSessionsByDefault [
		
	device workSessionsQueue should be isEmpty
]

{ #category : #tests }
PtyUIDeviceTest >> testRegisteringNewEndedWorkSession [
	
	| event |
	event := PtyWorkSessionEnded workSession: #workSession.
	device newWorkSessionEnded: event.
	
	device workSessionsQueue next should be: #workSession
]

{ #category : #tests }
PtyUIDeviceTest >> testRegisteringWorkSession [
	
	device registerWorkSession: #workSession1.
	device registerWorkSession: #workSession2.
	
	device workSessionsQueue next should be: #workSession1.
	device workSessionsQueue next should be: #workSession2
]

{ #category : #tests }
PtyUIDeviceTest >> testStartsUIUpdateTaskWhenAttachedToWorkplace [
	
	device stub.
	
	device attachToWorkplace. 
	
	device should receive startTask: (Kind of: PtyUIUpdateTask)
]

{ #category : #tests }
PtyUIDeviceTest >> testSubscribesToWorkSessionEndWhenAttachedToWorkplace [
	
	device attachToWorkplace. 
	
	workplace should receive when: PtyWorkSessionEnded send: #newWorkSessionEnded: to: device
]

{ #category : #tests }
PtyUIDeviceTest >> testUnsubscribesFromWoorkplaceWhenDetachedToWorkplace [
	
	device detachFromWorkplace. 
	
	workplace should receive unsubscribe: device
]
