Class {
	#name : #PtyGuideTests,
	#superclass : #TestCase,
	#instVars : [
		'guide'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyGuideTests >> setUp [
	super setUp.
		
	guide := PtyGuide new.
	
]

{ #category : #tests }
PtyGuideTests >> testActivationTaskContext [
	
	| actual |
	[:taskContext :activationRequest :currentContext | 
		guide viewArea: #currentViewArea.
		
		[actual := guide activateContext: taskContext]
			should strictly satisfy: 
		[taskContext parentViewArea: #currentViewArea.
		taskContext prepareActivationRequest willReturn: activationRequest.
		(activationRequest executeBy: guide inContext: taskContext)
			will: [guide context: currentContext. #result].
		currentContext changeParentAreaFor: #currentViewArea.
		currentContext parentViewArea willReturn: #parentViewArea.
		taskContext parent willReturn: #context.
		(currentContext prepareReturnContextTo: #context ) willReturn: #returnContext].
	
		actual should be: #result.
		guide viewArea should be: #parentViewArea.
		guide context should be: #returnContext.
		guide currentTasks last should be: taskContext
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingBackAction [
	
	[:viewArea :newViewArea | 
		guide viewArea: viewArea.
		
		[guide addBackAction]
			should strictly satisfy: 
		[viewArea createCopy willReturn: newViewArea.
		newViewArea addUserAction: (Instance of: PtyReturnToPreviousTask)].
	
		guide viewArea should be: newViewArea 	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingCancelAction [
	
	| task |
	[:viewArea :newViewArea | 
		guide viewArea: viewArea.
		guide context: #context.
			
		[guide addCancelAction]
			should strictly satisfy: 
		[viewArea createCopy willReturn: newViewArea.
		(newViewArea addUserAction: (Instance of: PtyStopTask))
			will: [:arg | task := arg]].
	
		task targetTaskContext should be: #context.
		guide viewArea should be: newViewArea 	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingItemToViewArea [
	
	[:viewArea :newViewArea | 
		guide viewArea: viewArea.
		
		[guide add: #presenter toViewAreaOn: #panelName]
			should strictly satisfy: 
		[viewArea createCopy willReturn: newViewArea.
		newViewArea add: #presenter on: #panelName].
	
		guide viewArea should be: newViewArea 	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingNamedTask [
	
	[:taskSource :task | 
		
		[guide addTask: taskSource named: #taskName]
			should strictly satisfy: 
		[taskSource asTask willReturn: task.
		task name: #taskName.
		task performExtraRequestBy: guide].	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingReturnAction [
	
	| task |
	[:viewArea :newViewArea | 
		guide viewArea: viewArea.
		guide context: #context.
			
		[guide addAction: #actionName returning: #taskResultObject]
			should strictly satisfy: 
		[viewArea createCopy willReturn: newViewArea.
		(newViewArea addUserAction: (Instance of: PtyResumeParentTask))
			will: [:arg | task := arg]].
	
		task returnContext should be: #context.
		task result should be: #taskResultObject.
		task name should be: #actionName.
		guide viewArea should be: newViewArea 	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingTask [
	
	[:taskSource :task | 
		
		[guide addTask: taskSource]
			should strictly satisfy: 
		[taskSource asTask willReturn: task.
		task performExtraRequestBy: guide].	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingUIActionToViewArea [
	
	[:viewArea :newViewArea | 
		guide viewArea: viewArea.
		
		[guide addUIAction: #uiActionBlock]
			should strictly satisfy: 
		[viewArea createCopy willReturn: newViewArea.
		newViewArea addUIAction: #uiActionBlock].
	
		guide viewArea should be: newViewArea 	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingUserAction [
	
	[:viewArea :newViewArea | 
		guide viewArea: viewArea.
		
		[guide addUserAction: #userAction]
			should strictly satisfy: 
		[viewArea createCopy willReturn: newViewArea.
		newViewArea addUserAction: #userAction].
	
		guide viewArea should be: newViewArea 	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testAddingViewAreaBody [
	
	[:viewArea :newViewArea | 
		guide viewArea: viewArea.
		
		[guide addViewAreaBody: #presenter]
			should strictly satisfy: 
		[viewArea createCopy willReturn: newViewArea.
		newViewArea addBody: #presenter].
	
		guide viewArea should be: newViewArea 	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testChangingContextParentArea [
	
	[:taskContext :taskActivation |
		guide viewArea: #viewArea.
		guide context: taskContext.
		
		[guide changeContextParentArea]
			should strictly satisfy: 
		[taskContext activation willReturn: taskActivation; useArbitrarily.
		taskActivation shouldRestoreParentArea willReturn: false.
		taskActivation parentViewArea: #viewArea].
	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testChangingContextParentAreaWhenItPermited [
	
	[:taskContext :taskActivation |
		guide viewArea: #viewArea.
		guide context: taskContext.
		
		[guide changeContextParentArea]
			should strictly satisfy: 
		[taskContext activation willReturn: taskActivation; useArbitrarily.
		taskActivation shouldRestoreParentArea willReturn: true].
	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testChangingLanguage [
	
	[:context :viewAreaActivator :translator | 
		guide translator: translator.
		guide context: context.
		[guide useLanguage: #lang]
			should strictly satisfy: 
		[translator currentLanguage: #lang.
		context viewAreaActivator willReturn: viewAreaActivator.
		viewAreaActivator translateViewportBy: translator].	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testCheckingCurrentRequestContainsTask [

	guide currentTasks: {PtyTaskContext of: #firstTask. PtyTaskContext of: #secondTask}.
	
	(guide isCurrentRequestIncludesTask: #firstTask) should be: true.
	
	(guide isCurrentRequestIncludesTask: #anotherTask) should be: false.
	
]

{ #category : #tests }
PtyGuideTests >> testCheckingCurrentRequestContainsTaskContext [

	guide currentTasks: #(#firstTaskContext. #secondTaskContext).
	
	(guide isCurrentRequestIncludes: #firstTaskContext) should be: true.
	
	(guide isCurrentRequestIncludes: #anotherTaskContext) should be: false.
	
]

{ #category : #tests }
PtyGuideTests >> testCreationTaskLikeRequested [
	
	[:settings | 
		guide uiSettings: settings.
		guide context: #context.
	
		[(guide createTaskLike: #requestedTask) should be: #newTask]
			should strictly satisfy: 
		[(settings appropriateTaskLike: #requestedTask inContextOf: #context) willReturn: #newTask]
	
	] runWithMocks 
]

{ #category : #tests }
PtyGuideTests >> testExecutionTaskShouldResetCurrentTasks [
	
	[:taskController :task | 
		guide taskController: taskController.
		guide currentTasks: #(1 2 3 ) asOrderedCollection.
		
		[guide executeTask: task]
			should strictly satisfy: 
		[taskController stopTask when: [guide currentTasks] is: (Has emptyItems) not.
		(taskController runTask: task) when: [guide currentTasks] is: Has emptyItems]	

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testForgetTask [
	
	[:taskContext :taskNavigator | 
		guide taskNavigator: taskNavigator.
		
		[guide forgetTask: #task]
			should strictly satisfy: 
		[taskNavigator forgetTask: #task]	

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testGettingCurrentTasksLikeSomeTaskContext [

	| actual |
	[:someTaskContext :similarTaskContext :differentTaskContex :parentTaskContext |
		guide currentTasks: {similarTaskContext. differentTaskContex. parentTaskContext}.
		[actual := guide currentTasksLike: someTaskContext]
			should lenient satisfy: 
		[someTaskContext taskClass willReturn: #givenTaskClass; useArbitrarily.
		
		(similarTaskContext hasParentLike: #givenTaskClass) willReturn: true.
		similarTaskContext task willReturn: #similarTask.
		(someTaskContext isCreatedInContextOf: #similarTask) willReturn: false.
		
		(differentTaskContex hasParentLike: #givenTaskClass) willReturn: false.
		
		(parentTaskContext hasParentLike: #givenTaskClass) willReturn: true.
		parentTaskContext task willReturn: #parentTask.
		(someTaskContext isCreatedInContextOf: #parentTask) willReturn: true].
	
		actual should equal: {similarTaskContext}
	] runWithMocks 
	
	
]

{ #category : #tests }
PtyGuideTests >> testHasNavigatorByDefault [
	
	guide taskNavigator should beInstanceOf: PtyTaskNavigator.
	guide taskNavigator guide should be: guide.
]

{ #category : #tests }
PtyGuideTests >> testHasNoCurrentTasksByDefault [
	
	guide currentTasks should be isEmpty
]

{ #category : #tests }
PtyGuideTests >> testHasResourcesManagerByDefault [
	
	guide resourcesManager should beInstanceOf: PtyResourcesManager
]

{ #category : #tests }
PtyGuideTests >> testHasTaskControllerByDefault [
	
	guide taskController should beInstanceOf: PtyTaskController.
	guide taskController guide should be: guide.
]

{ #category : #tests }
PtyGuideTests >> testHasTranslatorByDefault [
	
	guide translator should beInstanceOf: PtyTranslator
]

{ #category : #tests }
PtyGuideTests >> testHasUISettingsByDefault [
	
	guide uiSettings should beInstanceOf: PtyUISettings.
]

{ #category : #tests }
PtyGuideTests >> testHasUserByDefault [
	
	guide user should beInstanceOf: PtyUser.
	guide user guide should be: guide
]

{ #category : #tests }
PtyGuideTests >> testPerformingUserRequest [

	| request |
	[:taskContext :viewArea |
		guide context: taskContext.
		guide viewArea: viewArea.
			 
		[[guide performUserRequest] on: PtyUserRequest do: [:err | request := err]]
			should strictly satisfy: 
		[viewArea context: taskContext.
		viewArea setUpItemsContext: taskContext.
		taskContext viewAreaActivator willReturn: #activator].

		request viewAreaActivator should be: #activator
	] runWithMocks 
]

{ #category : #tests }
PtyGuideTests >> testPreparingPresenter [
	
	[:settings :presenter | 
		guide uiSettings: settings.
	
		[guide preparePresenter: presenter]
			should strictly satisfy: 
		[presenter guide: guide.
		presenter view willReturn: nil.
		settings createViewFor: presenter.
		presenter unhookModel.
		presenter createViewItems.
		presenter showViewItems.
		presenter hookupModel].

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testPreparingPresenterWhenItAlreadyHasView [
	
	[:settings :presenter | 
		guide uiSettings: settings.
	
		[guide preparePresenter: presenter]
			should strictly satisfy: 
		[presenter guide: guide.
		presenter view willReturn: #view.
		settings createViewFor: presenter.
		presenter unhookModel.
		presenter showViewItems.
		presenter hookupModel].

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testRememberTask [
	
	[:taskContext :taskNavigator | 
		guide taskNavigator: taskNavigator.
		
		[guide rememberTask: #task]
			should strictly satisfy: 
		[taskNavigator add: #task]	

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testRequestingUserForTask [
	
	[:currentContext :settings :newContext | 
		guide context: currentContext.
		guide uiSettings: settings.

		[(guide requestUserFor: #requestedTask) should be: #result]
			should strictly satisfy: 
		[(settings appropriateTaskLike: #requestedTask inContextOf: currentContext) 
			willReturn: #newTask.
		(currentContext createNewContextFor: #newTask) willReturn: newContext.
		(newContext activateBy: guide) willReturn: #result].

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testRetryingLastTask [
	
	[:taskContext :taskNavigator | 
		guide taskNavigator: taskNavigator.
		
		[guide retryLastTask]
			should strictly satisfy: 
		[taskNavigator lastTask willReturn: taskContext.
		(taskContext resumeFor: (Instance of: PtyRunTaskRequest))
			when: [guide currentTasks] is: (Containing item: taskContext)].	

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testSetUpContext [
	
	[:taskContext | 
		
		[guide setUpContext: taskContext]
			should strictly satisfy: 
		[taskContext parentViewArea willReturn: #parentArea].
	
		guide context should be: taskContext.
		guide viewArea should be: #parentArea

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testSetUpViewAreaContext [
	
	[:viewArea | 
		guide viewArea: viewArea.
		guide context: #context.
		
		[guide setUpViewAreaContext]
			should strictly satisfy: 
		[viewArea context: #context.
		viewArea setUpItemsContext: #context].	
		
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testShowingPresenterWithStyle [
	
	[:settings :presenter :currentView | 
		guide uiSettings: settings.
	
		[guide show: presenter withStyle: #style]
			should strictly satisfy: 
		[presenter style.
		presenter style: #style.
		presenter view willReturn: currentView.
		settings createViewFor: presenter.
		presenter showViewItems.
		presenter view willReturn: #newView.
		currentView replaceWith: #newView]	

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testShowingPresenterWithStyleWhenItAlreadyHasSameStyle [
	
	[:uiBuilder :presenter | 
		guide uiSettings: uiBuilder.
	
		[guide show: presenter withStyle: 'style' copy]
			should strictly satisfy: 
		[presenter style willReturn: 'style' copy]	
	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testShowingViewArea [
	
	[:viewArea | 
		guide viewArea: viewArea.
	
		[guide showViewAreaBy: #areaActivator] 
			should strictly satisfy: 
		[viewArea activateBy: #areaActivator]

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testTaskExecution [
	
	[:taskController :task | 
		guide taskController: taskController.
		
		[guide executeTask: task]
			should strictly satisfy: 
		[taskController stopTask.
		taskController runTask: task]

	] runWithMocks
]

{ #category : #tests }
PtyGuideTests >> testTranslationContentOfView [
	
	[:view | 
		guide translator: #translator.	
		[guide translateContentOf: view]
			should strictly satisfy: 
		[view translateContentBy: #translator].	
	] runWithMocks
]
