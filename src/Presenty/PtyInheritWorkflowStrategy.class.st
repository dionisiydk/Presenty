Class {
	#name : #PtyInheritWorkflowStrategy,
	#superclass : #PtyWorkflowActivationStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyInheritWorkflowStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	aWorkflow registerNewTask: aTask
]
