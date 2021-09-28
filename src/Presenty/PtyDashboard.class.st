Class {
	#name : #PtyDashboard,
	#superclass : #Object,
	#instVars : [
		'workflow',
		'view'
	],
	#category : #'Presenty-Tools'
}

{ #category : #'instance creation' }
PtyDashboard class >> for: aWorkflow [
	^self new 
		workflow: aWorkflow
]

{ #category : #building }
PtyDashboard >> build [ 
	view := PtyContainerMorph new.
	workflow updateControlPanel.
	workflow activateControlPanel.
	workflow spawnedWorkflows do: [ :each | 
		view addMorph: each controlPanel view ]
]

{ #category : #accessing }
PtyDashboard >> view [
	^ view
]

{ #category : #accessing }
PtyDashboard >> view: anObject [
	view := anObject
]

{ #category : #accessing }
PtyDashboard >> workflow [
	^ workflow
]

{ #category : #accessing }
PtyDashboard >> workflow: anObject [
	workflow := anObject
]
