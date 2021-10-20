Class {
	#name : #PtyDeviceTask,
	#superclass : #PtyTask,
	#instVars : [
		'device'
	],
	#category : #'Presenty-Devices'
}

{ #category : #'instance creation' }
PtyDeviceTask class >> for: aDevice [
	^self new 
		device: aDevice
]

{ #category : #testing }
PtyDeviceTask class >> isAbstract [ 
	^self = PtyDeviceTask 
]

{ #category : #accessing }
PtyDeviceTask >> device [
	^ device
]

{ #category : #accessing }
PtyDeviceTask >> device: anObject [
	device := anObject
]
