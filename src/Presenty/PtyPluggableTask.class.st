Class {
	#name : #PtyPluggableTask,
	#superclass : #PtyTask,
	#instVars : [
		'blockBody'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #'instance creation' }
PtyPluggableTask class >> from: aBlock [

	^self new 
		blockBody: aBlock 
]

{ #category : #'instance creation' }
PtyPluggableTask class >> from: aBlock named: aString [

	^self new 
		name: aString;
		blockBody: aBlock 
]

{ #category : #accessing }
PtyPluggableTask >> blockBody [
	^ blockBody
]

{ #category : #accessing }
PtyPluggableTask >> blockBody: anObject [
	blockBody := anObject
]

{ #category : #execution }
PtyPluggableTask >> body [

	^blockBody cull: user
]

{ #category : #printing }
PtyPluggableTask >> printOn: aStream [
	super printOn: aStream.
	
	blockBody printOn: aStream
]
