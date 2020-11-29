Class {
	#name : #PtyOneShotTaskReturnStrategy,
	#superclass : #PtyTaskReturnStrategy,
	#category : #'Presenty-Tasks'
}

{ #category : #'task execution' }
PtyOneShotTaskReturnStrategy >> prepareReturnFrom: aTask [
	
	aTask resumeInitialWorkflow
]
