Class {
	#name : #PtyUIUpdateTaskTest,
	#superclass : #TestCase,
	#category : #'Presenty-Tests-Devices'
}

{ #category : #tests }
PtyUIUpdateTaskTest >> testExecution [ 
	| uiDevice task process |
	uiDevice := Mock new.
	task := PtyUIUpdateTask for: uiDevice.
	
	process := [ task body ] forkAt: Processor activePriority + 1.
	
	uiDevice should receive processNextWorkSession
]
