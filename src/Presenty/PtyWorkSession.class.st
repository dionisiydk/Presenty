Class {
	#name : #PtyWorkSession,
	#superclass : #Object,
	#instVars : [
		'initialWorkflow'
	],
	#category : #Presenty
}

{ #category : #'instance creation' }
PtyWorkSession class >> for: aWorkflow [
	^self new 
		initialWorkflow: aWorkflow captureState 
]

{ #category : #accessing }
PtyWorkSession >> initialWorkflow [
	^ initialWorkflow
]

{ #category : #accessing }
PtyWorkSession >> initialWorkflow: anObject [
	initialWorkflow := anObject
]

{ #category : #'as yet unclassified' }
PtyWorkSession >> stopWorkflow: aWorkflow [
	aWorkflow resumeWorkflow: initialWorkflow
]
