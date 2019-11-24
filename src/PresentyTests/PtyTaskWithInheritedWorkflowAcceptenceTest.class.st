Class {
	#name : #PtyTaskWithInheritedWorkflowAcceptenceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyTaskWithInheritedWorkflowAcceptenceTest >> testExecutionAsChildTask [ 

	| task parentTask |
	task := [ workplace currentTasks should include: parentTask ] asTask useInheritedWorkflow.
	parentTask := [	user executeTask: task] asTask.
	
	user executeTask: parentTask
]
