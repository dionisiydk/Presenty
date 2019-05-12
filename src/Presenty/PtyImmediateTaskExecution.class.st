Class {
	#name : #PtyImmediateTaskExecution,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyImmediateTaskExecution >> execute: aTask using: aWorker [

	^aWorker executeTask: aTask
]
