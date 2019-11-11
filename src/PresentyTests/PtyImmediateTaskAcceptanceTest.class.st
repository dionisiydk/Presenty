Class {
	#name : #PtyImmediateTaskAcceptanceTest,
	#superclass : #PtyRealInteractionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutingAsChildTask [ 

	| task result |
	task := [ #result ] asTask.
	task beImmediate.
	
	user executeTask: [ result := user executeTask: task] asTask.

	result should be: #result.
	workplace currentTasks should include: task
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutingAsFirstTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beImmediate.
	
	user executeTask: task.
	
	workplace currentTasks should equal: { task }.
	result should be: #done
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testRetryingExecutionFromAnotherTask [ 

	| task result expected repeatOriginatorWasComplete |
	expected := #result.
	task := [ expected ] asTask.
	task beImmediate.	
	user executeTask: [ result := user executeTask: task] asTask.

	expected := #newResult.
	user executeTask: [ task repeatExecution. repeatOriginatorWasComplete := true] asTask.
	
	result should be: #newResult.
	repeatOriginatorWasComplete should not be: true
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testRetryingExecutionFromOutsideOfTask [ 

	| task result taskResult |
	taskResult := #result.
	task := [ taskResult ] asTask.
	task beImmediate.
	user executeTask: [ result := user executeTask: task] asTask.

	taskResult := #newResult.
	task repeatExecution.
	
	result should be: #newResult
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testReturningResultFromAnotherTask [ 

	| task result resultSenderWasComplete |
	task := [ #result ] asTask.
	task beImmediate.	
	user executeTask: [ result := user executeTask: task] asTask.

	user executeTask: [ task deliverResult: #newResult. resultSenderWasComplete := true] asTask.

	result should be: #newResult.
	resultSenderWasComplete should not be: true
	
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testReturningResultFromNotCurrentTask [ 

	| task result callerTask |
	task := [ #result ] asTask.
	task beImmediate.
	callerTask := [ result := user executeTask: task] asTask.
	callerTask beImmediate.
	user executeTask: callerTask.
	workplace currentTasks removeAll.
	 
	task deliverResult: #newResult.
	result should be: #newResult.
	workplace currentTasks should include: task.
	workplace currentTasks should include: callerTask
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testReturningResultFromOutsideOfTask [ 

	| task result |
	task := [ #result ] asTask.
	task beImmediate.
	user executeTask: [ result := user executeTask: task] asTask.

	task deliverResult: #newResult.
	
	result should be: #newResult
]
