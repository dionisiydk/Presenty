Class {
	#name : #PtyImmediateTaskExecution,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyImmediateTaskExecution >> requestExecutionOf: aTask using: aWorker [

	^aWorker executeTask: aTask
]
