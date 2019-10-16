Class {
	#name : #PtyWorkSession,
	#superclass : #Object,
	#instVars : [
		'parentSession',
		'workflows'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #initialization }
PtyWorkSession >> initialize [ 
	super initialize.
	
	workflows := OrderedCollection new
]

{ #category : #accessing }
PtyWorkSession >> parentSession [
	^ parentSession
]

{ #category : #accessing }
PtyWorkSession >> parentSession: anObject [
	parentSession := anObject
]

{ #category : #accessing }
PtyWorkSession >> workflows [
	^ workflows
]

{ #category : #accessing }
PtyWorkSession >> workflows: anObject [
	workflows := anObject
]
