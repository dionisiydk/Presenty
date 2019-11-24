Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyWorkplaceTest >> testCurrentTasksShouldIncludeAllTasksFromCurrentWorkflow [
	| workflow |
	workflow := Mock new.
	workplace currentWorkflow: workflow.

	workplace currentTasks should beReturnedFrom: [ workflow allCurrentTasks ]
]

{ #category : #tests }
PtyWorkplaceTest >> testFindWorkerExecutingCurrentTaskWhenActiveWorkerExists [

	| foundWorker activeWorker |
	activeWorker := Mock new.
	activeWorker stub isActive willReturn: true.
	workplace registerWorker: activeWorker.
	
	foundWorker := workplace findWorkerExecutingCurrentTask.
	
	foundWorker should be: activeWorker
]

{ #category : #tests }
PtyWorkplaceTest >> testFindWorkerExecutingCurrentTaskWhenNoActiveWorkersExist [

	| foundWorker existingWorker |
	existingWorker := Mock new.
	existingWorker stub isActive willReturn: false.
	workplace registerWorker: existingWorker.
	
	foundWorker := workplace findWorkerExecutingCurrentTask.
	
	workplace workers should not include: foundWorker.
	foundWorker should beInstanceOf: PtyWorker.
	foundWorker workplace should be: workplace
]

{ #category : #tests }
PtyWorkplaceTest >> testFindWorkerExecutingCurrentTaskWhenNoWorkersExist [

	| foundWorker |
	foundWorker := workplace findWorkerExecutingCurrentTask.
	
	workplace workers should not include: foundWorker.
	foundWorker should beInstanceOf: PtyWorker.
	foundWorker workplace should be: workplace
]

{ #category : #tests }
PtyWorkplaceTest >> testHasCurrentWorkflowByDefault [

	workplace currentWorkflow should beInstanceOf: PtyWorkflow
]

{ #category : #tests }
PtyWorkplaceTest >> testHasEmptyWorkersByDefault [

	workplace workers should be isEmpty
]

{ #category : #tests }
PtyWorkplaceTest >> testHasNoCurrentTasksByDefault [

	workplace currentTasks should be isEmpty
]

{ #category : #tests }
PtyWorkplaceTest >> testHaveDefaultTaskExecutionPriority [

	workplace defaultTaskExecutionPriority should not be: nil
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionShouldAssignActiveTaskAsParent [

	| requestedTask activeTask activeWorker |
	requestedTask := PtyTask new.
	activeTask := PtyTask new.
	activeTask workflow: #activeWorkflow.
	activeWorker := Mock new.
	activeWorker stub isActive willReturn: true.
	activeWorker stub activeTask willReturn: activeTask.
	workplace registerWorker: activeWorker.
		
	workplace planExecutionOf: requestedTask by: #user.
	
	requestedTask parentTask should be: activeTask.
	requestedTask workflow should be: #activeWorkflow.
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
PtyWorkplaceTest >> testPlanningTaskExecutionShouldSpawnNewWorkflowForIt [

	| requestedTask workflow |
	requestedTask := PtyTask new.
	workflow := Mock new.
	workplace currentWorkflow: workflow.
		
	workplace planExecutionOf: requestedTask by: #user.
	
	requestedTask workflow should beReturnedFrom: [workflow spawnNew]
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

{ #category : #tests }
PtyWorkplaceTest >> testRemoveAllTasks [
	| workflow |
	workflow := Mock new.
	workplace currentWorkflow: workflow.

	workplace removeAllTasks.
	
	workflow should receive removeAllTasks
]
