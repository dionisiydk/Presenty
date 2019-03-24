Class {
	#name : #PtyPluggableUserAction,
	#superclass : #PtyUserAction,
	#instVars : [
		'block'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyPluggableUserAction class >> from: aBlock [

	^self new 
		block: aBlock 
]

{ #category : #accessing }
PtyPluggableUserAction >> block [
	^ block
]

{ #category : #accessing }
PtyPluggableUserAction >> block: anObject [
	block := anObject
]

{ #category : #execution }
PtyPluggableUserAction >> execute [
	
	block cull: presenter 
]
