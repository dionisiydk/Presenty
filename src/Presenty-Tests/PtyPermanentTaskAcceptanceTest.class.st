Class {
	#name : #PtyPermanentTaskAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #tests }
PtyPermanentTaskAcceptanceTest >> testExecutionAsChildTask [ 

	| task |
	task := [ #result ] asTask bePermanent.
 	
	user executeTask: [ user executeTask: task] asTask bePermanent.

	workplace currentTasks should include: task
]

{ #category : #tests }
PtyPermanentTaskAcceptanceTest >> testExecutionAsFirstTask [ 

	| task |
	task := [ #result ] asTask bePermanent.
	
	user executeTask: task.
	
	workplace currentTasks should equal: { task }
]

{ #category : #tests }
PtyPermanentTaskAcceptanceTest >> testResultDeliveryFromNonCurrentTask [ 

	| task callerTask |
	task := [ ] asTask bePermanent.
	callerTask := [ user executeTask: task] asTask bePermanent.
	user executeTask: callerTask.
	workplace removeAllTasks.
	 
	task deliverResult: #result.
	workplace currentTasks should include: task.
	workplace currentTasks should include: callerTask
]
