Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'workplaceSettings'
	],
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
PtyWorkplaceTest >> testFindWorkerRequestingNewTaskWhenActiveWorkerExists [

	| foundWorker activeWorker |
	activeWorker := Mock new.
	activeWorker stub isActive willReturn: true.
	workplace addWorker: activeWorker.
	
	foundWorker := workplace findWorkerRequestingNewTask.
	
	foundWorker should be: activeWorker
]

{ #category : #tests }
PtyWorkplaceTest >> testFindWorkerRequestingNewTaskWhenNoActiveWorkersExist [

	| foundWorker existingWorker |
	existingWorker := Mock new.
	existingWorker stub isActive willReturn: false.
	workplace addWorker: existingWorker.
	
	foundWorker := workplace findWorkerRequestingNewTask.
	
	workplace workers should not include: foundWorker.
	foundWorker should beInstanceOf: PtyWorker.
	foundWorker workplace should be: workplace
]

{ #category : #tests }
PtyWorkplaceTest >> testFindWorkerRequestingNewTaskWhenNoWorkersExist [

	| foundWorker |
	foundWorker := workplace findWorkerRequestingNewTask.
	
	workplace workers should not include: foundWorker.
	foundWorker should beInstanceOf: PtyWorker.
	foundWorker workplace should be: workplace
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
PtyWorkplaceTest >> testPlanningTaskExecutionShouldPrepareRequestedTask [

	| requestedTask |
	requestedTask := Mock new.
	workplace stub findWorkerRequestingNewTask willReturn: #currentWorker.
	
	workplace planExecutionOf: requestedTask by: #user.
	
	requestedTask should receive beRequestedFor: #user from: #currentWorker
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionShouldReturnPreferredTask [

	| requestedTask plannedTask |
	requestedTask := Mock new.
	(workplace stub findPreferredTaskImplementing: requestedTask) willReturn: #preferredTask.
	
	plannedTask := workplace planExecutionOf: requestedTask by: #user.
	
	plannedTask should be: #preferredTask
]
