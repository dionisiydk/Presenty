Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyWorkplaceTest >> testAddNewWorker [

	| worker |
	worker := PtyWorker at: workplace.
	
	workplace addWorker: worker.
	
	workplace workers should include: worker
]

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

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionWhenThereAreWorkersButNobodyIsActive [

	| task executionPlan worker |
	task := [] asTask.
	worker := Mock new.
	workplace addWorker: worker.
	worker stub isActive willReturn: false.
	
	executionPlan := workplace planExecutionOf: task by: #user.
	
	executionPlan should beInstanceOf: PtyInitiateNewExecutionPlan.
	executionPlan task should be: task.
	task user should be: #user.
	executionPlan worker should not be: nil.
	workplace workers should include: executionPlan worker
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionWhenThereIsActiveWorker [

	| task executionPlan worker |
	task := [] asTask.
	worker := Mock new.
	workplace addWorker: worker.
	worker stub isActive willReturn: true.
	
	executionPlan := workplace planExecutionOf: task by: #user.
	
	executionPlan should beInstanceOf: PtyContinueActiveExecutionPlan.
	executionPlan task should be: task.
	task user should be: #user.
	executionPlan worker should be: worker
]
