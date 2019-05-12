Class {
	#name : #PtyTaskExecutionStrategy,
	#superclass : #Object,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> execute: aTask using: aWorker [

	self subclassResponsibility 
]
