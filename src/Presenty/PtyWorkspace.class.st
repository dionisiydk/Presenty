Class {
	#name : #PtyWorkspace,
	#superclass : #Object,
	#instVars : [
		'activeTasks'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyWorkspace >> activeTasks [
	^ activeTasks
]

{ #category : #accessing }
PtyWorkspace >> activeTasks: anObject [
	activeTasks := anObject
]

{ #category : #accessing }
PtyWorkspace >> addTask: aTask [

	activeTasks add: aTask
]

{ #category : #initialization }
PtyWorkspace >> initialize [
	super initialize.
	
	activeTasks := OrderedCollection new
]
