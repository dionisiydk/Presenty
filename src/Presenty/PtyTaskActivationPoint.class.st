Class {
	#name : #PtyTaskActivationPoint,
	#superclass : #Object,
	#instVars : [
		'callerContext',
		'activeTasks'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTaskActivationPoint class >> createdFrom: aTaskContext [

	^self new 
		callerContext: aTaskContext 
]

{ #category : #accessing }
PtyTaskActivationPoint >> activeTasks: anObject [
	activeTasks := anObject
]

{ #category : #accessing }
PtyTaskActivationPoint >> callerContext [
	^ callerContext
]

{ #category : #accessing }
PtyTaskActivationPoint >> callerContext: anObject [
	callerContext := anObject
]

{ #category : #accessing }
PtyTaskActivationPoint >> currentTasks [
	^ activeTasks
]
