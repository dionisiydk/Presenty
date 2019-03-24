Class {
	#name : #PtyTaskActivationRequest,
	#superclass : #Object,
	#instVars : [
		'task'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTaskActivationRequest class >> for: aTask [

	^self new 
		task: aTask 
]

{ #category : #execution }
PtyTaskActivationRequest >> executeBy: aGuide inContext: aTaskContext [
	self subclassResponsibility 
]

{ #category : #accessing }
PtyTaskActivationRequest >> task [
	^ task
]

{ #category : #accessing }
PtyTaskActivationRequest >> task: anObject [
	task := anObject
]
