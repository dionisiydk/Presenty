Class {
	#name : #PtyTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyTaskTests >> taskClass [
	^PtyTask
]

{ #category : #tests }
PtyTaskTests >> testAllowChangeParentViewAreaStateByDefaullt [
	
	task allowChangeParentViewAreaState should be: true
]

{ #category : #tests }
PtyTaskTests >> testAnnouncingWhenNoParents [
	
	[:announcer |
		task context: nil.
		task announcer: announcer.
		[task announce: #event]
			should strictly satisfy: 
		[announcer announce: #event]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testAnnouncingWhenParentExist [
	
	[:parentTask :announcer |
		task announcer: announcer.
		[task announce: #event]
			should strictly satisfy: 
		[announcer announce: #event.
		parentContext task willReturn: parentTask.
		parentTask announce: #event]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testCheckingCreationByCurrentRequest [
	
	[	
		[task isCreatedByCurrentRequest should be: #result]
			should strictly satisfy: 
		[(guide isCurrentRequestIncludesTask: task) willReturn: #result].	
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testCheckingPrototypeExistense [
	
	task prototype: nil.
	
	task hasPrototype should be: false.
	
	task prototype: #prototype.
	
	task hasPrototype should be: true
	
]

{ #category : #tests }
PtyTaskTests >> testCheckingSupplyingInstanceInContext [
	
	[:contextTask :boolResult |

		[(task canBePrototypeInContextOf: contextTask) should be: #result]
			should strictly satisfy: 
		[(contextTask isCreatedByCurrentRequestFrom: task) willReturn: boolResult.
		boolResult not willReturn: #result].
	
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testChildrenShouldNotRestoreParentAreaWhenActivationShouldNotRestore [
	
	[:activation |
		task activationStrategy: activation.
		[task isChildrenShouldRestoreParentArea should be: false]
			should strictly satisfy: 
		[activation shouldRestoreParentArea willReturn: false]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testChildrenShouldNotRestoreParentAreaWhenParentContextChildrenShouldNotRestoreIt [
	
	[:activation :parentTask |
		task activationStrategy: activation.
		[task isChildrenShouldRestoreParentArea should be: false]
			should strictly satisfy: 
		[activation shouldRestoreParentArea willReturn: true.
		parentContext shouldRestoreParentArea willReturn: false.
		parentContext task willReturn: parentTask.
		parentTask isChildrenShouldRestoreParentArea willReturn: false]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testChildrenShouldRestoreParentAreaWhenNoParentContext [
	
	[:activation |
		task activationStrategy: activation.
		task context: nil.
		[task isChildrenShouldRestoreParentArea should be: true]
			should strictly satisfy: 
		[activation shouldRestoreParentArea willReturn: true]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testChildrenShouldRestoreParentAreaWhenParentContextChildrenShouldRestoreIt [
	
	[:activation :parentTask |
		task activationStrategy: activation.
		[task isChildrenShouldRestoreParentArea should be: true]
			should strictly satisfy: 
		[activation shouldRestoreParentArea willReturn: true.
		parentContext shouldRestoreParentArea willReturn: false.
		parentContext task willReturn: parentTask.
		parentTask isChildrenShouldRestoreParentArea willReturn: true]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testChildrenShouldRestoreParentAreaWhenParentContextShouldRestoreIt [
	
	[:activation |
		task activationStrategy: activation.
		[task isChildrenShouldRestoreParentArea should be: true]
			should strictly satisfy: 
		[activation shouldRestoreParentArea willReturn: true.
		parentContext shouldRestoreParentArea willReturn: true]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testConvertingToUserAction [

	| actual |
	actual := task asUserAction.
	
	actual should beInstanceOf: PtyActivateTask.
	actual task should be: task
]

{ #category : #tests }
PtyTaskTests >> testCreatedByRequestFromParentWithRequestedClass [
	
	[:parentTask |

		[(task isCreatedByCurrentRequestFrom: #task) should be: true]
			should strictly satisfy: 
		[parentContext task willReturn: parentTask.
		parentTask isCreatedByCurrentRequest willReturn: true.
		(parentTask isSimilarTo: #task) willReturn: true].
	
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testCreatedByRequestWhenParentDoes [
	
	[:parentTask |

		[(task isCreatedByCurrentRequestFrom: #task) should be: true]
			should strictly satisfy: 
		[parentContext task willReturn: parentTask.
		parentTask isCreatedByCurrentRequest willReturn: true.
		(parentTask isSimilarTo: #task) willReturn: false.
		(parentTask isCreatedByCurrentRequestFrom: #task) willReturn: true].
	
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testCreationActivationRequest [
	
	| actual |
	actual := task activationRequest.
	
	actual should beInstanceOf: PtyRunTaskRequest.
	actual task should be: task
]

{ #category : #tests }
PtyTaskTests >> testCreationContextForActivation [
	
	| actual |
	actual := task createContextFor: #activation.
	
	actual should beInstanceOf: PtyTaskContext.
	actual task should be: task.
	actual activation should be: #activation
]

{ #category : #tests }
PtyTaskTests >> testGettingParent [
	
	[
		[task parent should be: #parentTask]
			should strictly satisfy: 
		[parentContext task willReturn: #parentTask]
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testGettingParentWhenParentContextAbsent [
	
	task context: nil.
	
	task parent should be: nil
]

{ #category : #tests }
PtyTaskTests >> testGettingPrototypeContextNameWhenConcreteNameSpecified [
	
	task name: 'specialTask'.
	
	task prototypeContextName should equal: 'specialTask'.
	
]

{ #category : #tests }
PtyTaskTests >> testGettingPrototypeContextNameWhenNoConcreteNameSpecified [
	
	task name: nil.
	
	task prototypeContextName should equal: task class name.
	
]

{ #category : #tests }
PtyTaskTests >> testHasAnnouncerByDefault [
	
	task announcer should beInstanceOf: Announcer
]

{ #category : #tests }
PtyTaskTests >> testNotCreatedByRequestFromParentWhenItAbsent [
	
	task context: nil.
	
	(task isCreatedByCurrentRequestFrom: #task) should be: false
]

{ #category : #tests }
PtyTaskTests >> testNotCreatedByRequestWhenParentNot [
	
	[:parentTask |

		[(task isCreatedByCurrentRequestFrom: #task) should be: false]
			should strictly satisfy: 
		[parentContext task willReturn: parentTask.
		parentTask isCreatedByCurrentRequest willReturn: true.
		(parentTask isSimilarTo: #task) willReturn: false.
		(parentTask isCreatedByCurrentRequestFrom: #task) willReturn: false].
	
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testNotCreatedByRequestWhenParentNotFromCurrentRequest [
	
	[:parentTask |

		[(task isCreatedByCurrentRequestFrom: #task) should be: false]
			should strictly satisfy: 
		[parentContext task willReturn: parentTask.
		parentTask isCreatedByCurrentRequest willReturn: false].
	
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testPerformingExtraRequest [
	
	| extraTask |
	[
		task guide: nil.
		
		[task performExtraRequestBy: guide]
			should strictly satisfy: 
		[(guide requestUserFor: (Instance of: PtyAddExtraTask))
			will: [:arg | extraTask := arg]].
	
		extraTask targetTask should be: task
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskTests >> testPreparingActivation [
	
	[:context :activation :newActivation |
		task guide: nil.
		task activationStrategy: activation.
		[(task prepareActivationBy: guide) should be: newActivation]
			should strictly satisfy: 
		[guide user willReturn: user.
		guide context willReturn: context.
		context activation willReturn: #parentActivation; useArbitrarily.
		activation createCopy willReturn: newActivation.
		newActivation guide: guide.
		newActivation parent: #parentActivation.
		newActivation prepareForEscapeTo: task fromContext: context].
	
		task guide should be: guide.
		task user should be: user.
		task context should be: context.
	] runWithMocks
	
]

{ #category : #tests }
PtyTaskTests >> testReadingParamsFromSample [
	
	| sampleTask |
	sampleTask := PtyTask new.
	sampleTask guide: #guide.
	sampleTask user: #user.
	sampleTask activationStrategy: #sampleActivation.
	
	task guide: nil.
	task user: nil.
	task activationStrategy: #taskActivation.
	
	task readFromSample: sampleTask.
	
	task guide should be: #guide.
	task user should be: #user.
	task activationStrategy should be: #taskActivation
]
