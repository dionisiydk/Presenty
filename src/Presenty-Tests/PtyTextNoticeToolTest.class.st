Class {
	#name : #PtyTextNoticeToolTest,
	#superclass : #PtyVisualToolTestCase,
	#category : #'Presenty-Tests-Tools'
}

{ #category : #running }
PtyTextNoticeToolTest >> createTool [
	^PtyTextNoticeTool label: #testLabel
]

{ #category : #tests }
PtyTextNoticeToolTest >> testActivationOnPanelShouldInitializeLabel [
	| view settings |
	settings := Mock new.
	targetTask stub settings willReturn: settings.
	view := Mock new.
	(settings stub preferredViewFor: tool) willReturn: view.
	
	tool activateOnPanel.
	
	view should receive contents: tool label
]
