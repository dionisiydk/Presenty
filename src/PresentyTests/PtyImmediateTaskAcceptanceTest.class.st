Class {
	#name : #PtyImmediateTaskAcceptanceTest,
	#superclass : #PtyRealInteractionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutionAsChildTask [ 

	| task result |
	task := [ #result ] asTask.
	task beImmediate.
	
	user executeTask: [ result := user executeTask: task] asTask.

	result should be: #result.
	workplace currentTasks should include: task
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutionAsFirstTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beImmediate.
	
	user executeTask: task.
	
	workplace currentTasks should equal: { task }.
	result should be: #done
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutionRetryFromAnotherTask [ 

	| task result expected repeatOriginatorWasComplete |
	expected := #result.
	task := [ expected ] asTask.
	task beImmediate.	
	user executeTask: [ result := user executeTask: task] asTask.

	expected := #newResult.
	user executeTask: [ task retryExecution. repeatOriginatorWasComplete := true] asTask.
	
	result should be: #newResult.
	repeatOriginatorWasComplete should not be: true
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutionRetryFromOutsideOfWorkplace [ 

	| task result taskResult |
	taskResult := #result.
	task := [ taskResult ] asTask.
	task beImmediate.
	user executeTask: [ result := user executeTask: task] asTask.

	taskResult := #newResult.
	task retryExecution.
	
	result should be: #newResult
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testResultDeliveryFromAnotherTask [ 

	| task result resultSenderWasComplete |
	task := [ #result ] asTask.
	task beImmediate.	
	user executeTask: [ result := user executeTask: task] asTask.

	user executeTask: [ task deliverResult: #newResult. resultSenderWasComplete := true] asTask.

	result should be: #newResult.
	resultSenderWasComplete should not be: true
	
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testResultDeliveryFromNonCurrentTask [ 

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
PtyImmediateTaskAcceptanceTest >> testResultDeliveryFromOutsideOfWorkplace [ 

	| task result |
	task := [ #result ] asTask.
	task beImmediate.
	user executeTask: [ result := user executeTask: task] asTask.

	task deliverResult: #newResult.
	
	result should be: #newResult
]
