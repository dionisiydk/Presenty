Class {
	#name : #PtySettings,
	#superclass : #Object,
	#instVars : [
		'viewLibrary'
	],
	#category : #'Presenty-Tools'
}

{ #category : #initialization }
PtySettings >> initialize [ 
	super initialize.
	
	viewLibrary := PtyViewLibrary default
]

{ #category : #accessing }
PtySettings >> preferredViewFor: aVisualTool [
	^aVisualTool chooseDefaultViewIn: viewLibrary
]

{ #category : #accessing }
PtySettings >> viewLibrary [
	^ viewLibrary
]

{ #category : #accessing }
PtySettings >> viewLibrary: anObject [
	viewLibrary := anObject
]
