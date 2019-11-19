Class {
	#name : #PtyImmediateExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyImmediateExecutionStrategy >> requestExecutionOf: aTask using: aWorker [

	^aWorker executeTask: aTask
]
