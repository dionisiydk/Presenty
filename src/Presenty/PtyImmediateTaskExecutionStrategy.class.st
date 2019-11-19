Class {
	#name : #PtyImmediateTaskExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyImmediateTaskExecutionStrategy >> requestExecutionOf: aTask using: aWorker [

	^aWorker executeTask: aTask
]
