Class {
	#name : #PtyOneShotTaskExecution,
	#superclass : #PtyTaskExecutionStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyOneShotTaskExecution >> prepareWorkflow: aWorkflow forReturnFrom: aTask [
	super prepareWorkflow: aTask forReturnFrom: aTask.
	
	aWorkflow removeTask: aTask
]

{ #category : #'task execution' }
PtyOneShotTaskExecution >> requestExecutionOf: aTask using: aWorker [

	^aWorker executeTask: aTask
]
