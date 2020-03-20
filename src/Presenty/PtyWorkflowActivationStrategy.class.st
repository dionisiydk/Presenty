Class {
	#name : #PtyWorkflowActivationStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyWorkflowActivationStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	self subclassResponsibility 
]
