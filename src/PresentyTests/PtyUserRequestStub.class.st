Class {
	#name : #PtyUserRequestStub,
	#superclass : #PtyUserRequest,
	#instVars : [
		'isExecuted'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #execution }
PtyUserRequestStub >> executeBy: aGuide [

	isExecuted := true
]

{ #category : #'initialize-release' }
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
