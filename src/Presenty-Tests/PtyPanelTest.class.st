Class {
	#name : #PtyPanelTest,
	#superclass : #PtyVisualToolTestCase,
	#category : #'Presenty-Tests-Tools'
}

{ #category : #running }
PtyPanelTest >> createTool [
	^PtyPanel new
]

{ #category : #running }
PtyPanelTest >> panel [
	^tool
]

{ #category : #tests }
PtyPanelTest >> testConfiguringViewForTool [

	| someTool view |
	someTool := Mock new.
	view := self panel configureViewForTool: someTool.
	
	view should beReturnedFrom: [ someTool chooseDefaultViewIn: self panel settings viewLibrary ]
]

{ #category : #tests }
PtyPanelTest >> testHasSettingsByDefault [

	self panel settings should beInstanceOf: PtySettings
]
