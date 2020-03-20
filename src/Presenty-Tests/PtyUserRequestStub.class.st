Class {
	#name : #PtyUserRequestStub,
	#superclass : #PtyUserRequest,
	#instVars : [
		'isExecuted'
	],
	#category : #'Presenty-Tests'
}

{ #category : #execution }
PtyUserRequestStub >> executeBy: aWorker [

	isExecuted := true
]

{ #category : #initialization }
PtyUserRequestStub >> initialize [ 
	super initialize.
	isExecuted := false
]

{ #category : #accessing }
PtyUserRequestStub >> isExecuted [
	^ isExecuted
]

{ #category : #accessing }
PtyUserRequestStub >> isExecuted: anObject [
	isExecuted := anObject
]
