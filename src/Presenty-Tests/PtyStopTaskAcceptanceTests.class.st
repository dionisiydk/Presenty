Class {
	#name : #PtyStopTaskAcceptanceTests,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testCanBeDoneFromChildTaskDuringExecution [

	| task childTask childTask2 |
	childTask := [ task stopExecution ] asTask bePermanent.	
	childTask2 := [ #result2 ] asTask bePermanent.
	task := [ user executeTask: childTask. user executeTask: childTask2 ] asTask bePermanent.
	
	user executeTask: task.
	
	workplace currentTasks should be isEmpty.
	
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testCanBeDoneFromTaskItself [

	| task |
	task := [ task stopExecution ] asTask bePermanent.	
	
	user executeTask: task.
	
	workplace currentTasks should be isEmpty
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testDoesNotRemoveChildrenOfParentFromAnotherRun [

	| task childTask childTask2 |
	childTask := [ #result ] asTask bePermanent.
	childTask2 := [ #result2 ] asTask bePermanent.	
	task := [ user executeTask: childTask. user executeTask: childTask2 ] asTask bePermanent.	
	user executeTask: task.
	
	childTask2 retryExecution.
	childTask2 stopExecution.
	
	workplace currentTasks should include: childTask
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testDoesNotRemoveOtherChildrenOfSpawningParent [
	| task childTask childTask2 |
	childTask := [ #result] asTask bePermanent useSeparateWorkflow.
	childTask2 := [ #result2 ] asTask bePermanent.
	task := [ user executeTask: childTask. user executeTask: childTask2 ] asTask bePermanent.	
	user executeTask: task.
	
	childTask stopExecution.
	
	workplace currentTasks should not include: childTask.
	workplace currentTasks should include: childTask2.
	
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testDoesNotRemoveParentWhenItWasNotInvolvedInLastRun [
	| childTask parentTask |
	childTask := [ #result ] asTask bePermanent.
	parentTask := [ user executeTask: childTask ] asTask bePermanent.	
	user executeTask: parentTask.
	workplace currentTasks should include: childTask.

	childTask retryExecution.	
	childTask stopExecution.
	
	workplace currentTasks should include: parentTask
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testDoesNotRemoveSpawningParent [
	| task childTask |
	childTask := [ #result ] asTask bePermanent useSeparateWorkflow.
	task := [ user executeTask: childTask ] asTask bePermanent.	
	user executeTask: task.
	
	childTask stopExecution.
	
	workplace currentTasks should not include: childTask.
	workplace currentTasks should include: task.
	
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testDoesNotRemoveTaskWhenStopHappensAfterRetry [

	| task |
	task := [ #result ] asTask bePermanent.	
	user executeTask: task.
	
	task retryExecution.
	task stopExecution.
	
	workplace currentTasks should include: task
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testDoesNotRestoreSpawningParentRemovedByChildOfSameWorkflow [

	| task childTask parentTask cleaningChild |
	childTask := [ #child ] asTask bePermanent.
	task := [ user executeTask: childTask ] asTask bePermanent useSeparateWorkflow.
	cleaningChild := [ PtyUserRequest signal ] asTask useCleanWorkflow.
	parentTask := [ user executeTask: task. user executeTask: cleaningChild ] asTask bePermanent.
	
	user executeTask: parentTask.
	workplace currentTasks should not include: parentTask.
	parentTask workflow currentTasks should include: cleaningChild.
	parentTask workflow spawnedWorkflows should be isEmpty.
	
	childTask stopExecution.
	workplace currentTasks should not include: parentTask.
	workplace currentTasks should include: cleaningChild.
	parentTask workflow spawnedWorkflows should not include: childTask workflow.
	childTask workflow currentTasks should be isEmpty
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testKeepsParentOfDeferredTaskAfterStopFromRetry [ 

	| task parentTask |
	task := [ task stopExecution ] asTask beDeferred.	
	parentTask := [ user executeTask: task] asTask.
	user executeTask: parentTask.

	task retryExecution.
	
	workplace currentTasks should include: task.
	workplace currentTasks should include: parentTask
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testRemovesOtherChildrenOfParentFromSameRun [

	| task childTask childTask2 childTask3 |
	childTask := [ #result ] asTask bePermanent.
	childTask2 := [ #result2 ] asTask bePermanent.	
	childTask3 := [ #result2 ] asTask bePermanent.
	task := [ user executeTask: childTask. user executeTask: childTask2. user executeTask: childTask3 ] asTask bePermanent.	
	user executeTask: task.
	
	childTask2 stopExecution.
	
	workplace currentTasks should be isEmpty.
	
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testRemovesParentFromSameRun [

	| task parentTask |
	task := [ #result ] asTask bePermanent.
	parentTask := [ user executeTask: task ] asTask bePermanent.	
	user executeTask: parentTask.
	workplace currentTasks should include: task.
	
	task stopExecution.
	
	workplace currentTasks should be isEmpty.
	
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testRemovesParentOfStoppedDeferredTask [

	| task parentTask |
	task := [ #deferredTask ] asTask beDeferred.	
	parentTask := [ user executeTask: task] asTask.
	user executeTask: parentTask.

	task stopExecution.
	
	workplace currentTasks should not include: task.
	workplace currentTasks should not include: parentTask
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testRemovesSeparatedChildren [

	| task childTask |
	childTask := [ #result ] asTask bePermanent useSeparateWorkflow.
	task := [ user executeTask: childTask ] asTask bePermanent.	
	user executeTask: task.
	task workSession should not be: childTask workSession.
	
	task stopExecution.
	
	workplace currentTasks should be isEmpty.
	
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testRemovesTask [

	| task |
	task := [ #result ] asTask bePermanent.	
	user executeTask: task.
	workplace currentTasks should include: task.
	
	task stopExecution.
	
	workplace currentTasks should be isEmpty
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testRestoresChildrenFromPreviousRun [
	| task retryStep previousChildTask activeChildTask |
	retryStep := false.
	previousChildTask := [ retryStep ifFalse: [ PtyUserRequest signal ] ] asTask bePermanent.
	activeChildTask := [ activeChildTask stopExecution ] asTask useCleanWorkflow.	
	task := [ user executeTask: previousChildTask. user executeTask: activeChildTask ] asTask bePermanent.	
	user executeTask: task.
	workplace currentTasks should include: previousChildTask.
	workplace currentTasks should include: task.
	
	retryStep  := true.
	
	previousChildTask retryExecution.
	
	workplace currentTasks should include: previousChildTask.
	workplace currentTasks should include: task.
	workplace currentTasks should not include: activeChildTask.
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testRestoresPreviousStateOfChildWhenStopIsAfterReturnFromDeferredChildTask [

	| task parentTask result |
	task := [ #deferredTask ] asTask beDeferred.
	parentTask := [ result := user executeTask: task. parentTask stopExecution ] asTask bePermanent.	
	user executeTask: parentTask.
	
	result should be: nil.
	task deliverResult: #newResult.
	
	result should be: #newResult.
	workplace currentTasks should include: task.
	workplace currentTasks should include: parentTask
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testRestoresPreviousStateOfChildWhenStopIsAfterSecondReturnFromIt [

	| task parentTask retryStep |
	retryStep := false.
	task := [ retryStep ifFalse: [ PtyUserRequest signal ] ] asTask beOneShot.
	parentTask := [ user executeTask: task. parentTask stopExecution ] asTask bePermanent.	
	user executeTask: parentTask.
	
	retryStep := true.
	task retryExecution.
	
	workplace currentTasks should include: task.
	workplace currentTasks should include: parentTask
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testTerminatesRunningChildTask [

	| task done taskTerminated semaphore childTask |
	taskTerminated := done := false.
	semaphore := Semaphore new.	
	childTask := [ [ semaphore wait ] ifCurtailed: [ taskTerminated := true ]. done := true ] asTask bePermanent.
	task := [ user executeTask: childTask ] asTask.
	user executeTask: task.
	taskTerminated should be: false.
	done should be: false.
	
	task stopExecution.
	
	taskTerminated should be: true.
	done should be: false.
	workplace currentTasks should be isEmpty
]

{ #category : #tests }
PtyStopTaskAcceptanceTests >> testTerminatesRunningTask [

	| task done taskTerminated semaphore |
	taskTerminated := done := false.
	semaphore := Semaphore new.	
	task := [ [ semaphore wait ] ifCurtailed: [ taskTerminated := true ]. done := true ] asTask bePermanent.	
	user executeTask: task.
	taskTerminated should be: false.
	done should be: false.
	
	task stopExecution.
	
	taskTerminated should be: true.
	done should be: false.
	workplace currentTasks should be isEmpty
]
