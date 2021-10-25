Class {
	#name : #PtyUIUpdateTask,
	#superclass : #PtyDeviceTask,
	#category : #'Presenty-Devices'
}

{ #category : #execution }
PtyUIUpdateTask >> body [
	device runUIUpdateLoop
]
