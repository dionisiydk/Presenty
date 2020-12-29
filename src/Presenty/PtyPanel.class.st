Class {
	#name : #PtyPanel,
	#superclass : #PtyVisualTool,
	#instVars : [
		'settings'
	],
	#category : #'Presenty-Tools'
}

{ #category : #initialization }
PtyPanel >> chooseDefaultViewIn: aViewLibrary [
	^aViewLibrary panelView
]

{ #category : #'tools configuration' }
PtyPanel >> configureViewForTool: aVisualTool [

	^settings preferredViewFor: aVisualTool
]

{ #category : #initialization }
PtyPanel >> initialize [ 	
	super initialize.
	
	settings := PtySettings new
]

{ #category : #accessing }
PtyPanel >> settings [
	^ settings
]

{ #category : #accessing }
PtyPanel >> settings: anObject [
	settings := anObject
]
