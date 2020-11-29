Class {
	#name : #PtyDashboard,
	#superclass : #Object,
	#instVars : [
		'view',
		'tools'
	],
	#category : #'Presenty-Tools'
}

{ #category : #accessing }
PtyDashboard >> tools [
	^ tools
]

{ #category : #accessing }
PtyDashboard >> tools: anObject [
	tools := anObject
]

{ #category : #accessing }
PtyDashboard >> view [
	^ view
]

{ #category : #accessing }
PtyDashboard >> view: anObject [
	view := anObject
]
