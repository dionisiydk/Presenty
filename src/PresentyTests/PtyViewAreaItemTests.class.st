Class {
	#name : #PtyViewAreaItemTests,
	#superclass : #TestCase,
	#instVars : [
		'item',
		'presenter',
		'panelName'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyViewAreaItemTests >> setUp [
	super setUp.
	
	presenter := Mock new.
	panelName := 'itemPanelName'.
	item := PtyViewAreaItem presenter: presenter on: panelName.
]

{ #category : #tests }
PtyViewAreaItemTests >> testShowingOnView [

	[:guide :view :panel |
		[item showOn: view by: guide]
			should strictly satisfy: 
		[guide context willReturn: #taskContext.
		presenter context: #taskContext.
		presenter view willReturn: nil; useArbitrarily.
		(view panelNamed: panelName) willReturn: panel; useArbitrarily.
		guide preparePresenter: presenter.
		presenter view willReturn: #presenterView.
		panel add: #presenterView] 
	] runWithMocks 
]
