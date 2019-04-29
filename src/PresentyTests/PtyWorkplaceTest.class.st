Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyWorkplaceTest >> testHasEmptyWorkersByDefault [

	workplace workers should be isEmpty
]

{ #category : #tests }
PtyWorkplaceTest >> testHasNoActiveTasksByDefault [

	workplace activeTasks should be isEmpty
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionWhenNoWorkersExists [

	| task executionPlan |
	task := [] asTask.
	executionPlan := workplace planExecutionOf: task by: #user.
	
	executionPlan should beInstanceOf: PtyInitiateNewExecutionPlan.
	executionPlan task should be: task.
	task user should be: #user.
	executionPlan worker should not be: nil.
	workplace workers should include: executionPlan worker
]
