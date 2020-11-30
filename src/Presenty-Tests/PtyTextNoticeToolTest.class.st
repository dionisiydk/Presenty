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
	(panel configureViewForTool: tool) willReturn: view.
	
	tool attachToPanel.
	
	view should receive contents: tool label 
]
