Class {
	#name : #PtyVisualizationAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#instVars : [
		'displayDevice'
	],
	#category : #'Presenty-Tests-Tools'
}

{ #category : #tests }
PtyVisualizationAcceptanceTest >> runCaseManaged [
	^ self runCase
]

{ #category : #running }
PtyVisualizationAcceptanceTest >> setUp [ 
	super setUp.
	
	workplace addDevice: PtyUIDevice new.
	displayDevice := workplace addDevice: PtyPharoWindowDisplayDevice new.
	workplace open
]

{ #category : #running }
PtyVisualizationAcceptanceTest >> tearDown [ 
	workplace close.
	
	super tearDown
	
]

{ #category : #tests }
PtyVisualizationAcceptanceTest >> testSingleLabel [

	| task mainPanel controlPanel |
	task := [ #labelExample ] asTask bePermanent.
	task addTool: (PtyTextNoticeTool label: #testLabel).
	
	user executeTask: task.
	 
	mainPanel := displayDevice mainPanel.
	mainPanel submorphs should haveSize: 1.
	controlPanel := mainPanel submorphs first.
	controlPanel should beInstanceOf: PtyContainerMorph.
	controlPanel submorphs first should beInstanceOf: StringMorph.
	controlPanel submorphs first contents should equal: #testLabel
]
