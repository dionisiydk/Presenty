Class {
	#name : #PtyDeferredExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyDeferredExecutionStrategy >> requestExecutionOf: aTask using: aWorker [

	^aWorker deferTask: aTask
]
