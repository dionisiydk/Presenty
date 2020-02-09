Class {
	#name : #PtyTaskWithSeparateWorkflowAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionAsChildTask [ 

	| task result executed |
	executed := false.
	task := [ executed := true ] asTask.
	task useSeparateWorkflow.
	
	user executeTask: [ result := user executeTask: task] asTask.

	executed should be: true.
	result should beInstanceOf: PtyTaskExecutionFutureResult
]

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionAsChildTaskWhichRequestsUser [

	| task result executed |
	executed := false.
	task := [ executed := true. PtyUserRequest signal ] asTask.
	task useSeparateWorkflow.
	
	user executeTask: [ result := user executeTask: task] asTask.

	executed should be: true.
	result should beInstanceOf: PtyTaskExecutionFutureResult
]

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionRetry [ 
	| task result executed currentTasks parentTask |
	task := [ executed := true. currentTasks := workplace currentTasks ] asTask.
	task useSeparateWorkflow.
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

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionRetryDoesNotContinueParentTask [ 
	| task executed parentCounter |
	parentCounter := 0.
	executed := false.
	task := [ executed := true ] asTask.
	task useSeparateWorkflow.
	user executeTask: [ user executeTask: task. parentCounter := parentCounter + 1] asTask.
	parentCounter should be: 1.
	executed := false.	
	task retryExecution.
	
	executed should be: true.
	parentCounter should be: 1.
]

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionRetryDoesNotContinueParentTaskWhenItRequestsUser [
	| task executed parentCounter |
	parentCounter := 0.
	executed := false.
	task := [ executed := true. PtyUserRequest signal ] asTask.
	task useSeparateWorkflow.
	user executeTask: [ user executeTask: task. parentCounter := parentCounter + 1] asTask.
	parentCounter should be: 1.
	executed := false.	
	task retryExecution.
	
	executed should be: true.
	parentCounter should be: 1.
]
