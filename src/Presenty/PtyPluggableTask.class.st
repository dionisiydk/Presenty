Class {
	#name : #PtyPluggableTask,
	#superclass : #PtyTask,
	#instVars : [
		'blockBody'
	],
	#category : #'Presenty-Core'
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

	^blockBody cull: guide cull: user
]

{ #category : #testing }
PtyPluggableTask >> canBePrototypeInContextOf: aTask [
	^true
]
