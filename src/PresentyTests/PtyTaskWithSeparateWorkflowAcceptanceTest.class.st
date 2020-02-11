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

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionRetryShouldRestoreMissingOneShotParentsFromParentWorkflows [
	| task parent grandparent currentTasksDuringChild |
	task := [ currentTasksDuringChild := workplace currentTasks ] asTask beOneShot useSeparateWorkflow.
	parent := [ user executeTask: task] asTask beOneShot useSeparateWorkflow.
	grandparent := [ user executeTask: parent] asTask beOneShot.
	
	user executeTask: grandparent.
	currentTasksDuringChild should equal: { grandparent. parent. task }.
	
	task retryExecution.
	currentTasksDuringChild should equal: { grandparent. parent. task }.
]

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testShouldBeIndependentFromOtherSeparateTasks [ 
	| task1 task2 currentTasksDuringTask1 currentTasksDuringTask2 parentTask child1 |
	child1 := [  ] asTask bePermanent.
	task1 := [ currentTasksDuringTask1 ifNotNil: [ user executeTask: child1 ]. 
		currentTasksDuringTask1 := workplace currentTasks ] asTask.
	task1 useSeparateWorkflow; bePermanent.
	task2 := [ currentTasksDuringTask2 := workplace currentTasks ] asTask bePermanent.
	parentTask := [ user executeTask: task1. user executeTask: task2] asTask bePermanent.
	user executeTask: parentTask.
	currentTasksDuringTask1 should equal: { parentTask. task1 }. 
	currentTasksDuringTask2 should equal: { parentTask. task1. task2.  }.

	task1 retryExecution.
	
	currentTasksDuringTask1 should equal: { parentTask. task1. task2. child1 }. 
	
	task2 retryExecution.
	currentTasksDuringTask2 should equal: { parentTask. task1. task2. child1 }.
]
