Class {
	#name : #PtyWorkflowActivationStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyWorkflowActivationStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	self subclassResponsibility 
]
