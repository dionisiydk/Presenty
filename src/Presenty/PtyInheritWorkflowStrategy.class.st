Class {
	#name : #PtyInheritWorkflowStrategy,
	#superclass : #PtyWorkflowActivationStrategy,
	#category : #'Presenty-Tasks'
}

{ #category : #'task execution' }
PtyInheritWorkflowStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	aWorkflow registerNewTask: aTask
]
