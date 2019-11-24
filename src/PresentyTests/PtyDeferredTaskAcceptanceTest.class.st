Class {
	#name : #PtyDeferredTaskAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutionAsChildTask [ 

	| task result |
	task := [ #result ] asTask beDeferred.
	
	user executeTask: [ result := user executeTask: task] asTask.

	result should be: nil.
	workplace currentTasks should include: task
]

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutionAsFirstTask [ 

	| task result |
	task := [ result := #done ] asTask beDeferred.
	
	user executeTask: task.
	
	workplace currentTasks should equal: { task }.
	result should be: nil
]

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutionRetryFromAnotherTask [ 

	| task result expected retryBlockEnds |
	expected := #result.
	task := [ expected ] asTask beDeferred.	
	user executeTask: [ result := user executeTask: task] asTask.

	expected := #newResult.
	user executeTask: [ task retryExecution. retryBlockEnds := true] asTask.
	
	result should be: #newResult.
	retryBlockEnds should not be: true
]

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutionRetryFromOutsideOfWorkplace [ 
	| task result taskResult |
	taskResult := #result.
	task := [ taskResult ] asTask beDeferred.
	
	user executeTask: [ result := user executeTask: task] asTask.
	
	taskResult := #newResult.
	task retryExecution.
	
	result should be: #newResult
]

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testResultDeliveryFromOutsideOfWorkplace [ 
	| task result taskResult |
	taskResult := #result.
	task := [ taskResult ] asTask beDeferred.
	
	user executeTask: [ result := user executeTask: task] asTask.
	
	task deliverResult: #newResult.
	
	result should be: #newResult
]
