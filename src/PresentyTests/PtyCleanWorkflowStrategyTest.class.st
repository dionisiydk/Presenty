Class {
	#name : #PtyCleanWorkflowStrategyTest,
	#superclass : #PtyTaskWorkflowActivationStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyCleanWorkflowStrategyTest >> createStrategy [
	^PtyCleanWorkflowStrategy new
]

{ #category : #tests }
PtyCleanWorkflowStrategyTest >> testShouldCleanWorkflowBeforeRegisteringGivenTask [
	
	strategy prepareWorkflow: workflow forExecutionOf: #task.
	
	[workflow removeAllTasks.
	workflow registerNewTask: #task] should beDoneInOrder 
]
