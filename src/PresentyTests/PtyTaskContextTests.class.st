Class {
	#name : #PtyTaskContextTests,
	#superclass : #TestCase,
	#instVars : [
		'task',
		'taskContext'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyTaskContextTests >> setUp [
	super setUp.
	
	task := Mock new.
	taskContext := PtyTaskContext of: task
]

{ #category : #tests }
PtyTaskContextTests >> testChangingParentAreaWhenActivationNotRequiredRestoreIt [

	[:activation |
		taskContext activation: activation.
		 
		[taskContext changeParentAreaFor: #newArea]
			should strictly satisfy: 
		[activation shouldRestoreParentArea willReturn: false.
		activation parentViewArea: #newArea]	
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testChangingParentAreaWhenActivationRequiredRestoreIt [

	[:activation |
		taskContext activation: activation.
		 
		[taskContext changeParentAreaFor: #newArea]
			should strictly satisfy: 
		[activation shouldRestoreParentArea willReturn: true]	
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testCopyAsNewReturn [

	| actual |
	[:activation |
		taskContext activation: activation.
		taskContext continuation: #continuation.
	
		[actual := taskContext copyAsNewReturn]
			should strictly satisfy: 
		[activation copy willReturn: #activationCopy].

		actual should beInstanceOf: PtyTaskContext.
		actual task should be: task.
		actual continuation should be: #continuation.
		actual activation should be: #activationCopy.

	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testCreatedInContextOfParentTask [

	[:parentContext |
		[(taskContext isCreatedInContextOf: #someTask) should be: #result]
			should strictly satisfy: 
		[task context willReturn: parentContext; useArbitrarily.
		(parentContext isCreatedInContextOf: #someTask) willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testGettingParent [

	[ 
		[taskContext parent should be: #parent]
			should strictly satisfy: 
		[task context willReturn: #parent]	
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testGettingParentViewArea [

	[:activation |
		taskContext activation: activation.
		
		[taskContext parentViewArea should be: #result]
			should strictly satisfy: 
		[activation parentViewArea willReturn: #result]	
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testGettingTaskCallChain [

	| actual |
	[:parentTask :parentContext |
		[actual := taskContext taskCallChain]
			should strictly satisfy: 
		[task context willReturn: parentContext.
		parentContext task willReturn: parentTask.
		parentTask context willReturn: nil].
	
		actual should haveSize: 2.
		actual first should be: task.
		actual last should be: parentTask
		
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testGettingViewAreaActivator [

	[:taskActivation |
		taskContext activation: taskActivation.
		[taskContext viewAreaActivator should be: #activator]
			should strictly satisfy: 
		[taskActivation areaActivator willReturn: #activator].
		
	] runWithMocks 	
]

{ #category : #tests }
PtyTaskContextTests >> testHasNotParentLikeSomeTaskWhenNoParentExists [

	[
		[(taskContext hasParentLike: #taskClass) should be: false]
			should strictly satisfy: 
		[task context willReturn: nil]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testHasNotParentLikeSomeTaskWhenParentNot [

	[:parentTask :parentContext |
		[(taskContext hasParentLike: #taskClass) should be: false]
			should strictly satisfy: 
		[task context willReturn: parentContext; useArbitrarily.
		task parent willReturn: parentTask.
		(parentTask isKindOf: #taskClass) willReturn: false.
		(parentContext hasParentLike: #taskClass) willReturn: false]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testHasParentLikeSomeTaskWhenParentHas [

	[:parentTask :parentContext |
		[(taskContext hasParentLike: #taskClass) should be: true]
			should strictly satisfy: 
		[task context willReturn: parentContext; useArbitrarily.
		task parent willReturn: parentTask.
		(parentTask isKindOf: #taskClass) willReturn: false.
		(parentContext hasParentLike: #taskClass) willReturn: true]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testHasParentLikeSomeTaskWhenParentLikeIt [

	[:parentTask :parentContext |
		[(taskContext hasParentLike: #taskClass) should be: true]
			should strictly satisfy: 
		[task context willReturn: parentContext; useArbitrarily.
		task parent willReturn: parentTask.
		(parentTask isKindOf: #taskClass) willReturn: true]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testNotCreatedInContextOfTaskWhenNoParent [

	[
		[(taskContext isCreatedInContextOf: #someTask) should be: false]
			should strictly satisfy: 
		[task context willReturn: nil]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testPrepareActivationForReturnFromContext [

	[:taskActivation |
		taskContext activation: taskActivation.
		[taskContext prepareActivationForReturnFrom: #taskContext]
			should strictly satisfy: 
		[taskActivation prepareForEscapeTo: task fromContext: #taskContext].
		
	] runWithMocks 	
]

{ #category : #tests }
PtyTaskContextTests >> testPrepareReturnContext [

	| actual |
	[:destinationContext :returnContext |

		[actual := taskContext prepareReturnContextTo: destinationContext]
			should strictly satisfy: 
		[destinationContext copyAsNewReturn willReturn: returnContext.
		returnContext prepareActivationForReturnFrom: taskContext].
	
		actual should be: returnContext
		
	] runWithMocks 	
]

{ #category : #tests }
PtyTaskContextTests >> testPreparingActivationRequest [

	[
		[taskContext prepareActivationRequest should be: #request]
			should strictly satisfy: 
		[task activationRequest willReturn: #request].
		
	] runWithMocks 	
]

{ #category : #tests }
PtyTaskContextTests >> testPreparingActivationRequestShouldCreateContinuation [

	| request |
	[
		[request := taskContext prepareActivationRequest.
		request == #request ifTrue: [taskContext continuation value: #newRequest]]
			should strictly satisfy: 
		[task activationRequest willReturn: #request].
		
		request should be: #newRequest.
	] runWithMocks 	
]

{ #category : #tests }
PtyTaskContextTests >> testResumingForRequest [

	[:continuation :activationRequest|
		taskContext continuation: continuation.
		
		[taskContext resumeFor: activationRequest]
			should strictly satisfy: 
		[activationRequest task: task.
		continuation value: activationRequest].
		
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testReturningValue [

	| request |
	[:continuation |
		taskContext continuation: continuation.
		
		[taskContext return: #result]
			should strictly satisfy: 
		[(continuation value: (Instance of: PtyTaskReturnRequest))
			will: [:arg | request := arg]].
		
		request returnValue should be: #result
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testSettingParentViewArea [

	[:activation |
		taskContext activation: activation.
		
		[taskContext parentViewArea: #viewArea]
			should strictly satisfy: 
		[activation parentViewArea: #viewArea]	
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testShouldBeCreatedInContextOfOwnTask [

	(taskContext isCreatedInContextOf: task) should be: true
]

{ #category : #tests }
PtyTaskContextTests >> testShouldBeDerivedFromParent [

	[
		[(taskContext isDerivedFrom: #parent) should be: true]
			should strictly satisfy: 
		[task context willReturn: #parent]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testShouldBeDerivedFromSameContinuation [

	(taskContext isDerivedFrom: taskContext) should be: true
]

{ #category : #tests }
PtyTaskContextTests >> testShouldChildrenRestoreParentArea [

	[
		taskContext task: task.
		
		[taskContext isChildrenShouldRestoreParentArea should be: #result]
			should strictly satisfy: 
		[task isChildrenShouldRestoreParentArea willReturn: #result]	
	] runWithMocks
]

{ #category : #tests }
PtyTaskContextTests >> testShouldNotBeDerivedFromAnotherTask [

	[
		[(taskContext isDerivedFrom: #anotherTask) should be: false]
			should strictly satisfy: 
		[task context willReturn: #parent]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskContextTests >> testShouldRestoreParentArea [

	[:activation |
		taskContext activation: activation.
		
		[taskContext shouldRestoreParentArea should be: #result]
			should strictly satisfy: 
		[activation shouldRestoreParentArea willReturn: #result]	
	] runWithMocks
]
