Class {
	#name : #PtyDeferredTaskExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyDeferredTaskExecutionStrategy >> requestExecutionOf: aTask using: aWorker [

	^aWorker deferTask: aTask
]
