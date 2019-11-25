Class {
	#name : #PtyOneShotTaskReturnStrategy,
	#superclass : #PtyTaskReturnStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyOneShotTaskReturnStrategy >> prepareWorkflow: aWorkflow forReturnFrom: aTask [
	
	aTask activateInitialWorkflow
]
