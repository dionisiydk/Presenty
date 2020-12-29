Class {
	#name : #PtyPanelTests,
	#superclass : #PtyVisualToolTestCase,
	#category : #'Presenty-Tests-Tools'
}

{ #category : #running }
PtyPanelTests >> createTool [
	^PtyPanel new
]

{ #category : #running }
PtyPanelTests >> panel [
	^tool
]

{ #category : #tests }
PtyPanelTests >> testConfiguringViewForTool [

	| someTool view |
	someTool := Mock new.
	view := self panel configureViewForTool: someTool.
	
	view should beReturnedFrom: [ someTool chooseDefaultViewIn: self panel settings viewLibrary ]
]

{ #category : #tests }
PtyPanelTests >> testHasSettingsByDefault [

	self panel settings should beInstanceOf: PtySettings
]
