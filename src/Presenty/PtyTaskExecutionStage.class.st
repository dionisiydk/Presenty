Class {
	#name : #PtyTaskExecutionStage,
	#superclass : #Object,
	#instVars : [
		'task'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyTaskExecutionStage class >> of: aTask [
	^self new 
		task: aTask
]

{ #category : #controlling }
PtyTaskExecutionStage >> continueExecution [
	self subclassResponsibility 
]

{ #category : #accessing }
PtyTaskExecutionStage >> task [
	^ task
]

{ #category : #accessing }
PtyTaskExecutionStage >> task: anObject [
	task := anObject
]
