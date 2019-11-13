Class {
	#name : #PtyUserRequest,
	#superclass : #Exception,
	#instVars : [
		'viewAreaActivator'
	],
	#category : #'Presenty-Core'
}

{ #category : #signalling }
PtyUserRequest class >> with: aViewAreaActivator [ 
	| request |
	request := self new.
	request viewAreaActivator: aViewAreaActivator.
	^request signal
]

{ #category : #execution }
PtyUserRequest >> executeBy: aWorker [

]

{ #category : #accessing }
PtyUserRequest >> viewAreaActivator [
	^ viewAreaActivator
]

{ #category : #accessing }
PtyUserRequest >> viewAreaActivator: anObject [
	viewAreaActivator := anObject
]
