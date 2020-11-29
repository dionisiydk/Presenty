Class {
	#name : #PtyButton,
	#superclass : #PtyVisualTool,
	#instVars : [
		'targetTask'
	],
	#category : #'Presenty-Tools'
}

{ #category : #accessing }
PtyButton >> targetTask [
	^ targetTask
]

{ #category : #accessing }
PtyButton >> targetTask: anObject [
	targetTask := anObject
]
