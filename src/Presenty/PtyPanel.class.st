Class {
	#name : #PtyPanel,
	#superclass : #PtyVisualTool,
	#instVars : [
		'settings'
	],
	#category : #'Presenty-Tools'
}

{ #category : #controlling }
PtyPanel >> activateOnPanel [

	view := targetTask settings preferredViewFor: self.
	components do: [ :each | each activateOnPanel ].

	panel ifNotNil: [ panel placeView: view ]
]

{ #category : #accessing }
PtyPanel >> addTool: aTool [ 
	components add: aTool
]

{ #category : #controlling }
PtyPanel >> attachToPanel [ 
	
	targetTask parentTask ifNil: [ ^self ].
	
	panel := targetTask parentTask controlPanel.
	panel addTool: self
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

{ #category : #controlling }
PtyPanel >> placeView: aView [ 
	view addView: aView
]

{ #category : #accessing }
PtyPanel >> removeAllTools [
	components removeAll
]

{ #category : #accessing }
PtyPanel >> removeTool: aTool [ 
	components remove: aTool
]

{ #category : #accessing }
PtyPanel >> settings [
	^ settings
]

{ #category : #accessing }
PtyPanel >> settings: anObject [
	settings := anObject
]
