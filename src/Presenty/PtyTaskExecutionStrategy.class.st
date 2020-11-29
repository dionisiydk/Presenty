Class {
	#name : #PtyTaskExecutionStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #'Presenty-Tasks'
}

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> requestExecutionOf: aTask in: aWorkflow [

	self subclassResponsibility 
]
