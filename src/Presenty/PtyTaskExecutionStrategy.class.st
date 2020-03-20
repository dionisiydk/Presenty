Class {
	#name : #PtyTaskExecutionStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> requestExecutionOf: aTask in: aWorkflow [

	self subclassResponsibility 
]
