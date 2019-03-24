Class {
	#name : #PtyBlockExecutionTask,
	#superclass : #PtyTask,
	#instVars : [
		'block'
	],
	#category : #'Presenty-BlockExecutionTasks'
}

{ #category : #'instance creation' }
PtyBlockExecutionTask class >> block: aBlock [
	
	^self new 
		block: aBlock 
]

{ #category : #'instance creation' }
PtyBlockExecutionTask class >> named: aString with: aBlock [
	
	^self new 
		name: aString;
		block: aBlock 
]

{ #category : #accessing }
PtyBlockExecutionTask >> block [
	^ block
]

{ #category : #accessing }
PtyBlockExecutionTask >> block: anObject [
	block := anObject
]
