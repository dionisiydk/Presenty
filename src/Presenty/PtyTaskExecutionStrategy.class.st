Class {
	#name : #PtyTaskExecutionStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> requestExecutionOf: aTask in: aWorkflow [

	self subclassResponsibility 
]
