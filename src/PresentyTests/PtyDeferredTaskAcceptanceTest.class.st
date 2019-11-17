Class {
	#name : #PtyDeferredTaskAcceptanceTest,
	#superclass : #PtyRealInteractionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutionAsChildTask [ 

	| task result |
	task := [ #result ] asTask.
	task beDeferred.
	
	user executeTask: [ result := user executeTask: task] asTask.

	result should be: nil.
	workplace currentTasks should include: task
]

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutionAsFirstTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beDeferred.
	
	user executeTask: task.
	
	workplace currentTasks should equal: { task }.
	result should be: nil
]

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutionRetryFromOutsideOfWorkplace [ 
	| task result taskResult |
	taskResult := #result.
	task := [ taskResult ] asTask.
	task beDeferred.
	
	user executeTask: [ result := user executeTask: task] asTask.
	
	taskResult := #newResult.
	task retryExecution.
	
	result should be: #newResult
]
