Class {
	#name : #PtyWorkplaceTest,
	#superclass : #PtyWorkplaceTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #tests }
PtyWorkplaceTest >> testAddingNewDevice [

	| device |
	device := PtyUIDevice new.
	
	workplace addDevice: device.
	
	workplace devices should include: device.
	device workplace should be: workplace
]

{ #category : #tests }
PtyWorkplaceTest >> testAnnouncesTheEndOfWorkSession [
	| workflow event |
	workflow := PtyWorkflow new.
	workflow startNewSession.
	workplace when: PtyWorkSessionEnded send: #value: to: [:ann | event := ann ].
	
	workplace endWorkSessionFor: workflow.
	
	event workSession should be: workflow currentSession
]

{ #category : #tests }
PtyWorkplaceTest >> testAssigningToUser [

	| user |
	user := PtyUser new.
		
	workplace user: user.
	
	workplace user should be: user.
	user workplace should be: workplace
]

{ #category : #tests }
PtyWorkplaceTest >> testClosing [

	| device1 device2 |
	device1 := Mock new.
	device2 := Mock new.
	workplace devices: { device1. device2 }.
	
	workplace close.
	
	device1 should receive detachFromWorkplace.
	device2 should receive detachFromWorkplace
]

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
PtyWorkplaceTest >> testHasDefaultTaskExecutionPriority [

	workplace defaultTaskExecutionPriority should not be: nil
]

{ #category : #tests }
PtyWorkplaceTest >> testHasEmptyDevicesByDeafult [

	workplace devices should be isEmpty
]

{ #category : #tests }
PtyWorkplaceTest >> testHasNoCurrentTasksByDefault [

	workplace currentTasks should be isEmpty
]

{ #category : #tests }
PtyWorkplaceTest >> testHasSettingsByDefault [

	workplace settings should beInstanceOf: PtySettings
]

{ #category : #tests }
PtyWorkplaceTest >> testOpening [

	| device1 device2 |
	device1 := Mock new.
	device2 := Mock new.
	workplace devices: { device1. device2 }.
	
	workplace open.
	
	device1 should receive attachToWorkplace.
	device2 should receive attachToWorkplace
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionShouldFirstAssignItActiveWorkflow [

	| requestedTask |
	requestedTask := Mock new.
	workplace stub.
	
	workplace planExecutionOf: requestedTask.
	
	[requestedTask assignToActiveWorkflowIn: workplace.
	workplace findPreferredTaskImplementing: requestedTask] should beDoneInOrder
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionShouldFirstAssignItToUser [

	| requestedTask user |
	requestedTask := Mock new.
	user := PtyUser new.
	workplace user: user.
	workplace stub.
	
	workplace planExecutionOf: requestedTask.
	
	[requestedTask user: user.
	workplace findPreferredTaskImplementing: requestedTask] should beDoneInOrder
]

{ #category : #tests }
PtyWorkplaceTest >> testPlanningTaskExecutionShouldReturnPreferredTask [

	| requestedTask plannedTask |
	requestedTask := Mock new.
	(workplace stub findPreferredTaskImplementing: requestedTask) willReturn: #preferredTask.
	
	plannedTask := workplace planExecutionOf: requestedTask.
	
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

{ #category : #tests }
PtyWorkplaceTest >> testUnsubscribingFromAnnouncements [
	
	workplace when: PtyWorkSessionEnded send: #someErrorMessage to: self.
	workplace unsubscribe: self.
	
	workplace endWorkSessionFor: Mock new
]
