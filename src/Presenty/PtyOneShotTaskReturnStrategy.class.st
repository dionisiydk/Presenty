Class {
	#name : #PtyOneShotTaskReturnStrategy,
	#superclass : #PtyTaskReturnStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyOneShotTaskReturnStrategy >> prepareWorkflow: aWorkflow forReturnFrom: aTask [
	
	aTask activateInitialWorkflow
]
