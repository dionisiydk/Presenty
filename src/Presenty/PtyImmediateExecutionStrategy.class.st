Class {
	#name : #PtyImmediateExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyImmediateExecutionStrategy >> requestExecutionOf: aTask in: aWorkflow [

	^aWorkflow executeTask: aTask
]
