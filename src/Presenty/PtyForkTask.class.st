Class {
	#name : #PtyForkTask,
	#superclass : #PtyAddExtraTask,
	#instVars : [
		'forkAreaPanelName'
	],
	#category : #'Presenty-Core'
}

{ #category : #testing }
PtyForkTask >> allowChangeParentViewAreaState [

	^true
]

{ #category : #execution }
PtyForkTask >> body [
	| forkActivation result |
	forkActivation := workplace context activation.
	self haltIf: [forkActivation parentViewArea isNil].

	[
		[^workplace requestUserFor: targetTask] on: PtyUserRequest	do: [ :request | 
			(workplace isCurrentRequestIncludesTask: self)	ifFalse: [ request pass ] ].
	] ensure: [
		(workplace isCurrentRequestIncludesTask: self)	ifTrue: [
			workplace viewArea name: 'ForkedArea'.
			forkActivation embedCurrentAreaToParentOn: forkAreaPanelName.
			forkActivation shareParentAreaWithCurrentRequests.
			workplace viewArea: forkActivation parentViewArea]
	]
]

{ #category : #testing }
PtyForkTask >> canBePrototypeInContextOf: aTask [
	^true
]

{ #category : #accessing }
PtyForkTask >> defaultActivationStrategy [ 
	^PtySeparatedTaskActivationStrategy new
		areaActivator: PtyInlinedAreaActivator new;
		shouldRestoreParentArea: true;
		shouldRememberTask: false;
		shouldForgetCompleteTask: true
]

{ #category : #accessing }
PtyForkTask >> forkAreaPanelName [
	^ forkAreaPanelName
]

{ #category : #accessing }
PtyForkTask >> forkAreaPanelName: anObject [
	forkAreaPanelName := anObject
]

{ #category : #'initialize-release' }
PtyForkTask >> initialize [ 
	super initialize.
	forkAreaPanelName := 'forkedTasksArea'
]

{ #category : #'morphic menu' }
PtyForkTask >> populateSettingsMenu: aMenu for: aPrototype [
	super populateSettingsMenu: aMenu for: aPrototype.
	
	aMenu 
		add: 'change fork area panel (' , forkAreaPanelName , ')' 
		target: (aPrototype proxyForSample: self) 
		action: #requestForkAreaPanelName
]

{ #category : #'morphic menu' }
PtyForkTask >> requestForkAreaPanelName [

	| newName |
	newName := UIManager default 
		request: 'Set fork area panel name' translated
		initialAnswer: forkAreaPanelName
		centerAt: Sensor cursorPoint.
	
	newName ifNil: [^self].
	
	forkAreaPanelName := newName
	
]
