Class {
	#name : #PtyWorkplace,
	#superclass : #Object,
	#instVars : [
		'activeTasks'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyWorkplace >> activeTasks [
	^ activeTasks
]

{ #category : #accessing }
PtyWorkplace >> activeTasks: anObject [
	activeTasks := anObject
]

{ #category : #accessing }
PtyWorkplace >> addTask: aTask [

	activeTasks add: aTask
]

{ #category : #initialization }
PtyWorkplace >> initialize [
	super initialize.
	
	activeTasks := OrderedCollection new
]
