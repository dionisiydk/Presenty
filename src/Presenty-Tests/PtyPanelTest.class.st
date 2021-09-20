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
PtyPanelTest >> testAttachToPanel [

	| parentTask |
	panel := Mock new.
	parentTask := Mock new.
	targetTask stub parentTask willReturn: parentTask.
	parentTask stub controlPanel willReturn: panel.
	
	tool attachToPanel.
	
	tool panel should be: panel.
	panel should receive addTool: tool.
]

{ #category : #tests }
PtyPanelTest >> testAttachToPanelWhenItIsForRootTask [

	tool panel: nil.
	targetTask stub parentTask willReturn: nil.
	
	tool attachToPanel.
	
	tool panel should be: nil
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
