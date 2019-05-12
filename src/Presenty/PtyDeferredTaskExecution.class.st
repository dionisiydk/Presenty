Class {
	#name : #PtyDeferredTaskExecution,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyDeferredTaskExecution >> execute: aTask using: aWorker [

	aWorker deferTask: aTask
]
