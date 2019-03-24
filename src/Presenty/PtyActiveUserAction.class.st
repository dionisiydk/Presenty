Class {
	#name : #PtyActiveUserAction,
	#superclass : #Object,
	#instVars : [
		'userAction'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyActiveUserAction class >> on: userAction [
	^ self new userAction: userAction
]

{ #category : #accessing }
PtyActiveUserAction >> actions [
	^ userAction presenter guide viewArea userActions
]

{ #category : #dispatching }
PtyActiveUserAction >> doesNotUnderstand: aMessage [
	aMessage sendTo: (self actions detect: [ :action | action id = userAction id ] ifNone: [ ^ self ])
]

{ #category : #private }
PtyActiveUserAction >> userAction: action [
	userAction := action
]
