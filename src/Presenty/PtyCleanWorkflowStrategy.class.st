Class {
	#name : #PtyCleanWorkflowStrategy,
	#superclass : #PtyWorkflowActivationStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyCleanWorkflowStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	aWorkflow removeAllTasks.
	aWorkflow registerNewTask: aTask
]
