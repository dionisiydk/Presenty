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
PtyPanelTest >> testActivationOnPanelShouldActivateComponents [
	| childTool1 childTool2 |
	childTool1 := Mock new.
	childTool2 := Mock new.
	tool addTool: childTool1; addTool: childTool2.
		
	tool activateOnPanel.
	
	childTool1 should receive activateOnPanel.
	childTool2 should receive activateOnPanel.
]

{ #category : #tests }
PtyPanelTest >> testActivationOnPanelWhenItIsRootItself [

	tool panel: nil.
			
	tool activateOnPanel
]

{ #category : #tests }
PtyPanelTest >> testAddTool [

	self panel addTool: #tool.
	
	self panel components should include: #tool
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

{ #category : #tests }
PtyPanelTest >> testPlaceView [

	| containerView |
	containerView := Mock new.
	self panel view: containerView.
	
	self panel placeView: #childView.
	
	containerView should receive addView: #childView
]

{ #category : #tests }
PtyPanelTest >> testRemoveAllTools [

	self panel addTool: #tool1; addTool: #tool2.
	
	self panel removeAllTools.
	
	self panel components should be isEmpty
]

{ #category : #tests }
PtyPanelTest >> testRemoveTool [

	self panel addTool: #tool.
	
	self panel removeTool: #tool.
	
	self panel components should not include: #tool
]
