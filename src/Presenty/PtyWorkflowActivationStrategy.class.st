Class {
	#name : #PtyWorkflowActivationStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #'Presenty-Tasks'
}

{ #category : #'task execution' }
PtyWorkflowActivationStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	self subclassResponsibility 
]
