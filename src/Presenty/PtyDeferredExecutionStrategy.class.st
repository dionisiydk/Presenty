Class {
	#name : #PtyDeferredExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyDeferredExecutionStrategy >> requestExecutionOf: aTask in: aWorkflow [

	^aWorkflow deferTask: aTask
]
