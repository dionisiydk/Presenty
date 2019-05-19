Class {
	#name : #PtyTaskExecutionStrategy,
	#superclass : #Object,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> completeExecutionOf: aTask using: aWorker [

]

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> prepareExecutionOf: aTask using: aWorker [

]

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> requestExecutionOf: aTask using: aWorker [

	self subclassResponsibility 
]
