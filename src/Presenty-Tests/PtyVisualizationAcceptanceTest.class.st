Class {
	#name : #PtyVisualizationAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'Presenty-Tests-Tools'
}

{ #category : #tests }
PtyVisualizationAcceptanceTest >> testSingleLabel [

	| task dashboard mainPanel controlPanel |
	task := [ #labelExample ] asTask bePermanent.
	user executeTask: task.
	
	task addTool: (PtyTextNoticeTool label: #testLabel).
	 
	dashboard := PtyDashboard for: workplace currentWorkflow.
	dashboard build.
	
	mainPanel := dashboard view.
	mainPanel submorphs should haveSize: 1.
	controlPanel := mainPanel submorphs first.
	controlPanel should beInstanceOf: PtyContainerMorph.
	controlPanel submorphs first should beInstanceOf: StringMorph.
	controlPanel submorphs first contents should equal: #testLabel
]
