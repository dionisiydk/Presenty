Class {
	#name : #PtyTaskWithNewWorkflowAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyTaskWithNewWorkflowAcceptanceTest >> testExecutionAsChildTask [ 

	| task result executed |
	executed := false.
	task := [ executed := true ] asTask.
	task useNewWorkflow.
	
	user executeTask: [ result := user executeTask: task] asTask.

	executed should be: true.
	result should beInstanceOf: PtyTaskExecutionFutureResult
]

{ #category : #tests }
PtyTaskWithNewWorkflowAcceptanceTest >> testExecutionRetry [ 
	| task result executed currentTasks parentTask |
	task := [ executed := true. currentTasks := workplace currentTasks ] asTask.
	task useNewWorkflow.
	parentTask := [ result := user executeTask: task] asTask.
	user executeTask: parentTask.
	result := #existingResult.
	executed := false.
	
	task retryExecution.
	
	result should be: #existingResult.
	executed should be: true.
	currentTasks should include: task.
	currentTasks should include: parentTask.
]
