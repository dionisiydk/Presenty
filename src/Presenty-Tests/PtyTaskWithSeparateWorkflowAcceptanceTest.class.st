Class {
	#name : #PtyTaskWithSeparateWorkflowAcceptanceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionAsChildDeferredTask [ 

	| task result executed parent |
	executed := false.
	task := [ executed := true ] asTask.
	task beDeferred; useSeparateWorkflow.
	parent := [ result := user executeTask: task] asTask bePermanent.
	user executeTask: parent.
	
	executed should be: false.
	result should beInstanceOf: PtyTaskExecutionFutureResult.
	workplace currentTasks should equal: { parent. task }.
	task workflow currentTasks should include: task
]

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
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionRetryOfChildDeferredTask [ 

	| task parent currentTasks |
	task := [ currentTasks := workplace currentTasks ] asTask.
	task beDeferred; useSeparateWorkflow.
	parent := [ user executeTask: task] asTask bePermanent.
	user executeTask: parent.
	currentTasks should be: nil.
	
	task retryExecution.
	currentTasks should equal: { parent. task }
]

{ #category : #tests }
PtyTaskWithSeparateWorkflowAcceptanceTest >> testExecutionRetryShouldRestoreMissingOneShotParentsFromParentWorkflows [
	| task parent grandparent currentTasksDuringChild |
	task := [ currentTasksDuringChild := workplace currentTasks ] asTask beOneShot useSeparateWorkflow.
	parent := [ user executeTask: task] asTask beOneShot useSeparateWorkflow.
	grandparent := [ user executeTask: parent] asTask beOneShot.
	
	user executeTask: grandparent.
	currentTasksDuringChild should equal: { grandparent. parent. task }.
	currentTasksDuringChild := nil.
	
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
