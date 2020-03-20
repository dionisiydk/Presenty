Class {
	#name : #PtyInheritWorkflowStrategy,
	#superclass : #PtyWorkflowActivationStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyInheritWorkflowStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	aWorkflow registerNewTask: aTask
]
