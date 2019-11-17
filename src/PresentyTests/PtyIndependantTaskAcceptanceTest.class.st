Class {
	#name : #PtyIndependantTaskAcceptanceTest,
	#superclass : #PtyRealInteractionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyIndependantTaskAcceptanceTest >> testExecutionAsChildTask [ 

	| task result executed |
	executed := false.
	task := [ executed := true ] asTask.
	task beImmediate beIndependent.
	
	user executeTask: [ result := user executeTask: task] asTask.

	executed should be: true.
	result should beInstanceOf: PtyTaskExecutionFutureResult.
	workplace currentWorkflow spawnedWorkflows should haveSize: 1.
	workplace currentWorkflow spawnedWorkflows first spawnedWorkflows should haveSize: 1.
	workplace currentWorkflow spawnedWorkflows first spawnedWorkflows should include: task
]

{ #category : #tests }
PtyIndependantTaskAcceptanceTest >> testExecutionRetryDoesNotReturnToParent [ 

	| task result executed |
	executed := false.
	task := [ executed := true ] asTask.
	task beImmediate beIndependent.
	user executeTask: [ result := user executeTask: task] asTask.

	result := #existingResult.
	executed := false.
	task retryExecution.
	
	result should be: #existingResult.
	executed should be: true.
]
