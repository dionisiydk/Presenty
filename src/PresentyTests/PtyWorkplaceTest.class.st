Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyWorkplaceTest >> testAddNewWorker [

	| worker |
	worker := PtyWorker atWorkplace: workplace.
	
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
	task := Mock new.
	executionPlan := workplace planExecutionOf: task by: #user.
	
	workplace workers should haveSize: 1.
	executionPlan should beReturnedFrom: [task prepareExecutionPlan: PtyInitiateNewExecutionPlan by: workplace workers first].
	task should receive user: #user.
	workplace workers first workplace should be: workplace
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionWhenThereAreWorkersButNobodyIsActive [

	| task executionPlan worker |
	task := Mock new.
	worker := Mock new.
	workplace addWorker: worker.
	worker stub isActive willReturn: false.
	
	executionPlan := workplace planExecutionOf: task by: #user.
	
	executionPlan should beReturnedFrom: [task prepareExecutionPlan: PtyInitiateNewExecutionPlan by: workplace workers last].
	workplace workers should haveSize: 2
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionWhenThereIsActiveWorker [

	| task executionPlan worker |
	task := Mock new.
	worker := Mock new.
	workplace addWorker: worker.
	worker stub isActive willReturn: true.
	
	executionPlan := workplace planExecutionOf: task by: #user.
	
	executionPlan should beReturnedFrom: [task prepareExecutionPlan: PtyContinueActiveExecutionPlan by: worker].
]
