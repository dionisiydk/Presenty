Class {
	#name : #PtyNewWorkflowStrategy,
	#superclass : #PtyWorkflowActivationStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyNewWorkflowStrategy >> prepareWorkflow: aWorkflow forExecutionOf: aTask [

	| newWorkflow |
	newWorkflow := aWorkflow spawnNew.
	
	aTask workflow: newWorkflow.
	
	newWorkflow registerNewTask: aTask
]
