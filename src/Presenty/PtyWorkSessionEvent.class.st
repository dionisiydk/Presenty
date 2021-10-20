Class {
	#name : #PtyWorkSessionEvent,
	#superclass : #Announcement,
	#instVars : [
		'workSession'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #accessing }
PtyWorkSessionEvent class >> workSession: aWorkSession [
	^self new 
		workSession: aWorkSession
]

{ #category : #accessing }
PtyWorkSessionEvent >> workSession [
	^ workSession
]

{ #category : #accessing }
PtyWorkSessionEvent >> workSession: anObject [
	workSession := anObject
]
