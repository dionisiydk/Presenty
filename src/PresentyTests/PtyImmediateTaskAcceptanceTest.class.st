Class {
	#name : #PtyImmediateTaskAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutionAsChildTask [ 

	| task result |
	task := [ #result ] asTask beImmediate.
	
	user executeTask: [ result := user executeTask: task] asTask.

	result should be: #result
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutionAsFirstTask [ 

	| task result |
	task := [ result := #done ] asTask beImmediate.
	
	user executeTask: task.
	
	result should be: #done
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutionRetryFromAnotherTask [ 

	| task result expected retryBlockEnds |
	expected := #result.
	task := [ expected ] asTask beImmediate.	
	user executeTask: [ result := user executeTask: task] asTask.

	expected := #newResult.
	user executeTask: [ task retryExecution. retryBlockEnds := true] asTask.
	
	result should be: #newResult.
	retryBlockEnds should not be: true
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testExecutionRetryFromOutsideOfWorkplace [ 

	| task result taskResult |
	taskResult := #result.
	task := [ taskResult ] asTask beImmediate.
	user executeTask: [ result := user executeTask: task] asTask.

	taskResult := #newResult.
	task retryExecution.
	
	result should be: #newResult
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testNewTaskCallDuringExecutionRetry [ 
	| task result shouldCallChild newChild |
	shouldCallChild := false.
	newChild := [ #newResult ] asTask beImmediate.
	task := [ shouldCallChild 
			ifTrue: [user executeTask: newChild] ifFalse: [ #firstResult ] 
	] asTask beImmediate.
	user executeTask: [ result := user executeTask: task] asTask.
	shouldCallChild := true.
	
	task retryExecution.
	
	newChild parentTask should be: task.
	result should be: #newResult
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testResultDeliveryFromAnotherTask [ 

	| task result resultSenderWasComplete |
	task := [ #result ] asTask beImmediate.	
	user executeTask: [ result := user executeTask: task] asTask.

	user executeTask: [ task deliverResult: #newResult. resultSenderWasComplete := true] asTask.

	result should be: #newResult.
	resultSenderWasComplete should not be: true
	
]

{ #category : #tests }
PtyImmediateTaskAcceptanceTest >> testResultDeliveryFromOutsideOfWorkplace [ 

	| task result |
	task := [ #result ] asTask beImmediate.
	user executeTask: [ result := user executeTask: task] asTask.

	task deliverResult: #newResult.
	
	result should be: #newResult
]
