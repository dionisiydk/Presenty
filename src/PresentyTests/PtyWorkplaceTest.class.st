Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#category : #'PresentyTests-NewCore'
}

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
	executionPlan implementingTask should be: task.
	task user should be: #user.
	executionPlan worker should not be: nil.
	workplace workers should include: executionPlan worker
]
