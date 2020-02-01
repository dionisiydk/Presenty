Class {
	#name : #PtyNewWorkflowStrategyTest,
	#superclass : #PtyTaskWorkflowActivationStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyNewWorkflowStrategyTest >> createStrategy [
	^PtyNewWorkflowStrategy new
]

{ #category : #tests }
PtyNewWorkflowStrategyTest >> testShouldAssignSpawnedWorkflowToTask [
	
	task := [ ] asTask.
	
	strategy prepareWorkflow: workflow forExecutionOf: task.
	
	task workflow should beReturnedFrom: [ workflow spawnNew ]
]

{ #category : #tests }
PtyNewWorkflowStrategyTest >> testShouldRegisterTaskItselfInExecutionWorkflow [
	
	| newWorkflow |
	task := [ ] asTask.
	newWorkflow := Mock new.	
	workflow stub spawnNew willReturn: newWorkflow.
	
	strategy prepareWorkflow: workflow forExecutionOf: task.
	
	newWorkflow should receive registerNewTask: task
]
