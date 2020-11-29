Class {
	#name : #PtyTaskWithCleanWorkflowAcceptenceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #tests }
PtyTaskWithCleanWorkflowAcceptenceTest >> testExecutionAsChildTask [ 

	| task parentTask |
	task := [ workplace currentTasks should not include: parentTask ] asTask useCleanWorkflow.
	parentTask := [	user executeTask: task] asTask.
	
	user executeTask: parentTask
]
