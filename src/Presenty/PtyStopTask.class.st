Class {
	#name : #PtyStopTask,
	#superclass : #PtyTask,
	#instVars : [
		'targetTaskContext'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyStopTask class >> on: aTask [

	^self new 
		targetTaskContext: aTask 
]

{ #category : #execution }
PtyStopTask >> body [ 

	guide context: targetTaskContext.
	
	user stopCurrentTask 
]

{ #category : #accessing }
PtyStopTask >> targetTaskContext [
	^ targetTaskContext
]

{ #category : #accessing }
PtyStopTask >> targetTaskContext: anObject [
	targetTaskContext := anObject
]
