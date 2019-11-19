Class {
	#name : #PtyInheritedWorkflowActivationStrategy,
	#superclass : #PtyWorkflowActivationStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyInheritedWorkflowActivationStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	aWorkflow registerNewTask: aTask
]
