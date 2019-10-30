Class {
	#name : #PtyDeferredTaskExecution,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyDeferredTaskExecution >> requestExecutionOf: aTask using: aWorker [

	^aTask deferExecution.

]
