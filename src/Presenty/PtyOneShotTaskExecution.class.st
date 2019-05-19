Class {
	#name : #PtyOneShotTaskExecution,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyOneShotTaskExecution >> completeExecutionOf: aTask using: aWorker [
	super completeExecutionOf: aTask using: aWorker.
	
	aWorker removeTask: aTask
]

{ #category : #'task execution' }
PtyOneShotTaskExecution >> requestExecutionOf: aTask using: aWorker [

	^aWorker executeTask: aTask
]
