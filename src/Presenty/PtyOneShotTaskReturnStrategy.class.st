Class {
	#name : #PtyOneShotTaskReturnStrategy,
	#superclass : #PtyTaskReturnStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyOneShotTaskReturnStrategy >> prepareReturnFrom: aTask [
	
	aTask resumeInitialWorkflow
]
