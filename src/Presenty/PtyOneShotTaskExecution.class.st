Class {
	#name : #PtyOneShotTaskExecution,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyOneShotTaskExecution >> execute: aTask using: aWorker [

	^aWorker executeTask: aTask
]
