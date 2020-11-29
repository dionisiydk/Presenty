Class {
	#name : #PtyVisualizationAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'Presenty-Tests-Tools'
}

{ #category : #tests }
PtyVisualizationAcceptanceTest >> testSingleLabel [

	| task dashboard mainPanel |
	task := [ #labelExample ] asTask bePermanent.
	user executeTask: task.
	
	task addTool: (PtyTextNoticeTool label: #testLabel).
	
	dashboard := PtyDashboard for: workplace.
	dashboard build.
	
	mainPanel := dashboard view.
	mainPanel submorphs should haveSize: 1.
	mainPanel submorphs first should beInstanceOf: StringMorph.
	mainPanel submorphs first contents should equal: #testLabel
]
