Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#category : #'Presenty-Tests'
}

{ #category : #tests }
PtyWorkplaceTest >> testCurrentTasksShouldIncludeAllTasksFromCurrentWorkflow [
	| workflow |
	workflow := Mock new.
	workplace currentWorkflow: workflow.

	workplace currentTasks should beReturnedFrom: [ workflow allCurrentTasks ]
]

{ #category : #tests }
PtyWorkplaceTest >> testFindActiveWorkflow [

	| mainWorkflow foundWorkflow |
	mainWorkflow := Mock new.
	workplace currentWorkflow: mainWorkflow.
	
	foundWorkflow := workplace findActiveWorkflowOrCreateNewOne.
	
	foundWorkflow should beReturnedFrom: [ mainWorkflow findActiveWorkflowIfNone: Any ]
]

{ #category : #tests }
PtyWorkplaceTest >> testFindActiveWorkflowWhenItDoesNotExist [

	| mainWorkflow foundWorkflow |
	mainWorkflow := Mock new.
	workplace currentWorkflow: mainWorkflow.
	(mainWorkflow stub findActiveWorkflowIfNone: Any) will: [ :noneBlock | noneBlock value ].
	
	foundWorkflow := workplace findActiveWorkflowOrCreateNewOne.
	
	foundWorkflow should beReturnedFrom: [ mainWorkflow spawnNew ].
	foundWorkflow should receive worker: [ :worker | worker workplace = workplace ]
]

{ #category : #tests }
PtyWorkplaceTest >> testHasCurrentWorkflowByDefault [

	workplace currentWorkflow should beInstanceOf: PtyWorkflow
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
PtyWorkplaceTest >> testPlanningTaskExecutionShouldFirstAssignItActiveWorkflow [

	| requestedTask |
	requestedTask := Mock new.
	workplace stub.
	
	workplace planExecutionOf: requestedTask by: #user.
	
	[requestedTask assignToActiveWorkflowIn: workplace.
	workplace findPreferredTaskImplementing: requestedTask] should beDoneInOrder
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionShouldFirstAssignItToUser [

	| requestedTask |
	requestedTask := Mock new.
	workplace stub.
	
	workplace planExecutionOf: requestedTask by: #user.
	
	[requestedTask user: #user.
	workplace findPreferredTaskImplementing: requestedTask] should beDoneInOrder
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
PtyWorkplaceTest >> testRemoveAllTasks [
	| workflow |
	workflow := Mock new.
	workplace currentWorkflow: workflow.

	workplace removeAllTasks.
	
	workflow should receive removeAllTasks
]
