Class {
	#name : #PtyPanel,
	#superclass : #PtyVisualTool,
	#instVars : [
		'settings'
	],
	#category : #'Presenty-Tools'
}

{ #category : #controlling }
PtyPanel >> attachToPanel [ 
	
	targetTask parentTask ifNil: [ ^self ].
	
	panel := targetTask parentTask controlPanel.
	panel addTool: self
]

{ #category : #controlling }
PtyPanel >> attachToWorkflow [

	workflow allCurrentTasks do: [ :each | 
			components addAll: each tools
	]
]

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

{ #category : #testing }
PtyPanel >> isPanel [ 
	^true
]

{ #category : #accessing }
PtyPanel >> settings [
	^ settings
]

{ #category : #accessing }
PtyPanel >> settings: anObject [
	settings := anObject
]
