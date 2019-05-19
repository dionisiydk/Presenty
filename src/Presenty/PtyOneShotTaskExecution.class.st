Class {
	#name : #PtyOneShotTaskExecution,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyOneShotTaskExecution >> requestExecutionOf: aTask using: aWorker [

	^aWorker executeTask: aTask
]
