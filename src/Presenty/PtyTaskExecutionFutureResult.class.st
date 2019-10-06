Class {
	#name : #PtyTaskExecutionFutureResult,
	#superclass : #Object,
	#instVars : [
		'task'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyTaskExecutionFutureResult class >> of: aTask [
	^self new 
		task: aTask
]

{ #category : #accessing }
PtyTaskExecutionFutureResult >> task [
	^ task
]

{ #category : #accessing }
PtyTaskExecutionFutureResult >> task: anObject [
	task := anObject
]
