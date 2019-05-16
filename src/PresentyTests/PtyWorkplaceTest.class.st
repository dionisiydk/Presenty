Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'workplaceSettings'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyWorkplaceTest >> testFindWorkerRequestingNewTaskWhenActiveWorkerExists [

	| foundWorker activeWorker |
	activeWorker := Mock new.
	activeWorker stub isActive willReturn: true.
	workplace registerWorker: activeWorker.
	
	foundWorker := workplace findWorkerRequestingNewTask.
	
	foundWorker should be: activeWorker
]

{ #category : #tests }
PtyWorkplaceTest >> testFindWorkerRequestingNewTaskWhenNoActiveWorkersExist [

	| foundWorker existingWorker |
	existingWorker := Mock new.
	existingWorker stub isActive willReturn: false.
	workplace registerWorker: existingWorker.
	
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
PtyWorkplaceTest >> testHaveDefaultTaskExecutionPriority [

	workplace defaultTaskExecutionPriority should not be: nil
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

{ #category : #tests }
PtyWorkplaceTest >> testRegisterActiveTask [

	| worker task |
	worker := PtyWorker atWorkplace: workplace.
	task := [] asTask.
	task worker: worker.
	
	workplace registerActiveTask: task.
	
	workplace workers should include: worker.
	workplace activeTasks should include: task
]

{ #category : #tests }
PtyWorkplaceTest >> testRegisteringNewWorker [

	| worker |
	worker := PtyWorker atWorkplace: workplace.
	
	workplace registerWorker: worker.
	
	workplace workers should include: worker
]

{ #category : #tests }
PtyWorkplaceTest >> testRegisteringSameWorkerTwice [

	| worker |
	worker := PtyWorker atWorkplace: workplace.
	
	workplace registerWorker: worker.
	workplace registerWorker: worker.
	
	workplace workers should haveSize: 1.
	workplace workers should include: worker
]
