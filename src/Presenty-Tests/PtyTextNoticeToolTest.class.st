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
PtyTextNoticeToolTest >> testAttachingToPanel [

	| view |
	view := Mock new.
	(panel stub configureViewForTool: tool) willReturn: view.
	
	tool activateOnPanel.
	
	view should receive contents: tool label.
	panel should receive placeTool: tool
]
