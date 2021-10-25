Class {
	#name : #PtyUIUpdateTaskTest,
	#superclass : #TestCase,
	#category : #'Presenty-Tests-Devices'
}

{ #category : #tests }
PtyUIUpdateTaskTest >> testExecution [ 
	| uiDevice task |
	uiDevice := Mock new.
	task := PtyUIUpdateTask for: uiDevice.
	
	task body.
	
	uiDevice should receive runUIUpdateLoop
]
