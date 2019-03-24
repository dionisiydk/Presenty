Class {
	#name : #PtyEmbeddedAreaActivator,
	#superclass : #PtyViewAreaActivator,
	#instVars : [
		'targetPanelName'
	],
	#category : #'Presenty-Core'
}

{ #category : #activation }
PtyEmbeddedAreaActivator >> activateViewportBy: aGuide [

	| viewport |
	viewport := parentActivator activateViewportBy: aGuide.

	(viewport panelNamed: targetPanelName) 
		clear;
		add: baseArea view.	
		
	^baseArea view
	
]

{ #category : #'initialize-release' }
PtyEmbeddedAreaActivator >> initialize [ 
	super initialize.
	
	targetPanelName := 'embeddedAreasBar'
]

{ #category : #activation }
PtyEmbeddedAreaActivator >> prepareViewportBy: aGuide [

	parentActivator hasPreparedViewport ifFalse: [parentActivator prepareViewportBy: aGuide].

	baseArea := PtyViewAreaPresenter named: 'baseViewArea'.
	baseArea context: aGuide context.
	aGuide preparePresenter: baseArea.
	
	
]

{ #category : #accessing }
PtyEmbeddedAreaActivator >> targetPanelName [
	^ targetPanelName
]

{ #category : #accessing }
PtyEmbeddedAreaActivator >> targetPanelName: anObject [
	targetPanelName := anObject
]
