Class {
	#name : #PtyDeferredExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyDeferredExecutionStrategy >> requestExecutionOf: aTask in: aWorkflow [

	^aWorkflow deferTask: aTask
]
