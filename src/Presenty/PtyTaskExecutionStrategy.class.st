Class {
	#name : #PtyTaskExecutionStrategy,
	#superclass : #Object,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	aWorkflow registerNewTask: aTask
]

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> prepareWorkflow: aWorkflow forReturnFrom: aTask [

]

{ #category : #'task execution' }
PtyTaskExecutionStrategy >> requestExecutionOf: aTask using: aWorker [

	self subclassResponsibility 
]
