Class {
	#name : #PtyCleanWorkflowStrategyTest,
	#superclass : #PtyTaskWorkflowActivationStrategyTestCase,
	#category : #'Presenty-Tests-Tasks'
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
