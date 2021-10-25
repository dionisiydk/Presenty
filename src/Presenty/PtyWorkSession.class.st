Class {
	#name : #PtyWorkSession,
	#superclass : #Object,
	#instVars : [
		'initialWorkflow',
		'finalWorkflow'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #'instance creation' }
PtyWorkSession class >> for: aWorkflow [
	^self new 
		initialWorkflow: aWorkflow captureState 
]

{ #category : #accessing }
PtyWorkSession >> finalWorkflow [
	^ finalWorkflow
]

{ #category : #accessing }
PtyWorkSession >> finalWorkflow: anObject [
	finalWorkflow := anObject
]

{ #category : #accessing }
PtyWorkSession >> initialWorkflow [
	^ initialWorkflow
]

{ #category : #accessing }
PtyWorkSession >> initialWorkflow: anObject [
	initialWorkflow := anObject
]

{ #category : #controlling }
PtyWorkSession >> stopWorkflow: aWorkflow [
	aWorkflow resumeWorkflow: initialWorkflow
]
