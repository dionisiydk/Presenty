Class {
	#name : #PtyGuide,
	#superclass : #Object,
	#instVars : [
		'translator',
		'resourcesManager',
		'taskController',
		'taskNavigator',
		'user',
		'context',
		'viewArea',
		'uiSettings',
		'modelManager',
		'activeTasks'
	],
	#category : #'Presenty-Core'
}

{ #category : #'task execution' }
PtyGuide >> activateContext: aTaskContext [

	| activationRequest result |
	activeTasks add: aTaskContext.
	aTaskContext parentViewArea: viewArea.
	activationRequest := aTaskContext prepareActivationRequest.	
	
	result := activationRequest executeBy: self inContext: aTaskContext.
		
	context changeParentAreaFor: viewArea.	
	viewArea := context parentViewArea.
	context := context prepareReturnContextTo: aTaskContext parent.
	
	^result
]

{ #category : #'changing view area' }
PtyGuide >> add: aPresenter toViewAreaOn: panelName [ 

	viewArea := viewArea createCopy.
	
	viewArea add: aPresenter on: panelName
]

{ #category : #'changing view area' }
PtyGuide >> addAction: actionName returning: anObject [
	
	| task |
	task := PtyResumeParentTask from: context with: anObject.
	task name: actionName.
	
	^ self addUserAction: task 
]

{ #category : #accessing }
PtyGuide >> addActiveTask: aTaskContext [ 
	activeTasks add: aTaskContext 
]

{ #category : #'changing view area' }
PtyGuide >> addBackAction [

	self addUserAction: PtyReturnToPreviousTask new
]

{ #category : #'changing view area' }
PtyGuide >> addCancelAction [
	
	self addUserAction: (PtyStopTask on: context)
]

{ #category : #'changing view area' }
PtyGuide >> addContinueAction [
	^ self addAction: 'ContinueAction' returning: nil
]

{ #category : #'task execution' }
PtyGuide >> addTask: taskSource [

	| task forkTask |
	task := taskSource asTask.

	task performExtraRequestBy: self
]

{ #category : #'task execution' }
PtyGuide >> addTask: taskSource named: taskName [

	| task forkTask |
	task := taskSource asTask.
	task name: taskName.

	task performExtraRequestBy: self
]

{ #category : #'changing view area' }
PtyGuide >> addUIAction: aBlock [
	
	viewArea := viewArea createCopy.
	
	viewArea addUIAction: aBlock 
]

{ #category : #'changing view area' }
PtyGuide >> addUserAction: userActionSource [

	viewArea := viewArea createCopy.
	
	^ PtyActiveUserAction on: (viewArea addUserAction: userActionSource) 
]

{ #category : #'changing view area' }
PtyGuide >> addViewAreaBody: aPresenter [

	viewArea := viewArea createCopy.
	
	viewArea addBody: aPresenter
]

{ #category : #presentation }
PtyGuide >> changeContextParentArea [ 

	context activation shouldRestoreParentArea ifTrue: [^self].
	
	context activation parentViewArea: viewArea 
]

{ #category : #accessing }
PtyGuide >> context [
	^ context
]

{ #category : #accessing }
PtyGuide >> context: aTaskContext [

	context := aTaskContext
]

{ #category : #accessing }
PtyGuide >> createTaskLike: aTask [

	^uiSettings appropriateTaskLike: aTask inContextOf: context 
]

{ #category : #accessing }
PtyGuide >> currentTasks [
	^ activeTasks
]

{ #category : #accessing }
PtyGuide >> currentTasks: anObject [
	activeTasks := anObject
]

{ #category : #'task execution' }
PtyGuide >> currentTasksLike: aTaskContext [
"
	returns all task which created from same kind of (aTaskContext task class), 
	except tasks which created aTaskContext 
"
	^activeTasks select: [:each |
		(each hasParentLike: aTaskContext taskClass) and: [	
			(aTaskContext isCreatedInContextOf: each task) not]]
]

{ #category : #'task execution' }
PtyGuide >> executeTask: aTask [

	taskController stopTask.	

	activeTasks removeAll.

	taskController runTask: aTask 
]

{ #category : #accessing }
PtyGuide >> findCurrentTaskLike: taskClass [
	
	^(activeTasks reversed detect: [:each | each task isKindOf: taskClass] ifNone: [^nil]) task
]

{ #category : #'task execution' }
PtyGuide >> fixForkTasksFor: aForkTaskContext [

	activeTasks do: [:eachTask |
		((eachTask hasParentLike: PtyForkTask) and: [	
			(aForkTaskContext isCreatedInContextOf: eachTask task) not])
				ifTrue: [eachTask activation parentViewArea: viewArea]]
]

{ #category : #'task execution' }
PtyGuide >> forgetTask: aTask [

	taskNavigator forgetTask: aTask 
]

{ #category : #'initialize-release' }
PtyGuide >> initialize [ 
	super initialize.
	
	taskNavigator := PtyTaskNavigator for: self.
	uiSettings := PtyUISettings new.
	translator := PtyTranslator new.
	resourcesManager := PtyResourcesManager new.
	taskController := PtyTaskController of: self.
	context := PtyNullTaskContext new.
	activeTasks := OrderedCollection new.
	user := PtyUser guide: self
]

{ #category : #testing }
PtyGuide >> isCurrentRequestIncludes: aTaskContext [ 
	^activeTasks includes: aTaskContext 
]

{ #category : #testing }
PtyGuide >> isCurrentRequestIncludesTask: aTask [ 
	^activeTasks anySatisfy: [:each | each task = aTask]
]

{ #category : #accessing }
PtyGuide >> modelManager [
	^ modelManager ifNil: [ modelManager := PtyModelManager new ]
]

{ #category : #'task execution' }
PtyGuide >> notifyUserAbout: anError [

	anError pass
]

{ #category : #'task execution' }
PtyGuide >> performUserRequest [

	self setUpViewAreaContext.
	PtyUserRequest with: context viewAreaActivator
]

{ #category : #'ui menu' }
PtyGuide >> populateMenuItems: aMenu [

	aMenu add: 'remove yellow items' translated target: self selector: #removeYellowItems argumentList: #().
	aMenu addLine.
]

{ #category : #presentation }
PtyGuide >> preparePresenter: aPresenter [

	| viewExists |
	aPresenter guide: self.
	viewExists := aPresenter view notNil.
	uiSettings createViewFor: aPresenter.
	aPresenter unhookModel.
	viewExists ifFalse: [aPresenter createViewItems].
	aPresenter showViewItems.
	aPresenter hookupModel
]

{ #category : #'task execution' }
PtyGuide >> rememberTask: aTaskContext [
	taskNavigator add: aTaskContext 
]

{ #category : #'ui menu' }
PtyGuide >> removeYellowItems [

	PtyViewContainer allSubclasses,  {PtyViewContainer} do: [:each | 
		(each allInstances	
			select: [:morph | morph color = Color yellow]) do: [:morph | morph beTransparent].
		(each allInstances 
			select: [:morph | morph borderColor = Color red]) 
			do: [:morph | morph borderColor: Color transparent; borderWidth: 0].
	]
	

]

{ #category : #'task execution' }
PtyGuide >> requestUserFor: requestedTask [

	| activation newTask newContext |

	newTask := uiSettings appropriateTaskLike: requestedTask inContextOf: context.	

	newContext := context createNewContextFor: newTask.
	
	^newContext activateBy: self
]

{ #category : #accessing }
PtyGuide >> resourcesManager [
	^ resourcesManager
]

{ #category : #accessing }
PtyGuide >> resourcesManager: anObject [
	resourcesManager := anObject
]

{ #category : #'task execution' }
PtyGuide >> retryLastTask [

	| lastTask |
	lastTask := taskNavigator lastTask.
	activeTasks add: lastTask.
	
	lastTask resumeFor: PtyRunTaskRequest new.
	
	
	
]

{ #category : #presentation }
PtyGuide >> runInUI: aBlock [

	WorldState addDeferredUIMessage: aBlock 
]

{ #category : #'task execution' }
PtyGuide >> setUpContext: aTaskContext [

	context := aTaskContext.
	viewArea := aTaskContext parentViewArea 
]

{ #category : #presentation }
PtyGuide >> setUpViewAreaContext [
	viewArea context: context.
	viewArea setUpItemsContext: context
]

{ #category : #presentation }
PtyGuide >> show: aPresenter withStyle: styleName [ 

	| currentView |
	aPresenter style = styleName ifTrue: [^self].

	aPresenter style: styleName.
	currentView := aPresenter view.
	uiSettings createViewFor: aPresenter.
	aPresenter showViewItems.
	currentView replaceWith: aPresenter view
]

{ #category : #'task execution' }
PtyGuide >> showViewAreaAndContinue [

	user lookAtViewAreaAnd: [
		self executeTask: (PtyResumeParentTask from: context)
	]

]

{ #category : #presentation }
PtyGuide >> showViewAreaBy: aViewAreaActivator [
	
	viewArea activateBy: aViewAreaActivator 
]

{ #category : #accessing }
PtyGuide >> taskController [
	^ taskController
]

{ #category : #accessing }
PtyGuide >> taskController: anObject [
	taskController := anObject
]

{ #category : #accessing }
PtyGuide >> taskNavigator [
	^ taskNavigator
]

{ #category : #accessing }
PtyGuide >> taskNavigator: anObject [
	taskNavigator := anObject
]

{ #category : #presentation }
PtyGuide >> translateContentOf: aView [

	aView translateContentBy: translator
]

{ #category : #accessing }
PtyGuide >> translator [
	^ translator
]

{ #category : #accessing }
PtyGuide >> translator: anObject [
	translator := anObject
]

{ #category : #accessing }
PtyGuide >> uiSettings [
	^ uiSettings
]

{ #category : #accessing }
PtyGuide >> uiSettings: anUISettings [
	uiSettings := anUISettings 
]

{ #category : #presentation }
PtyGuide >> useLanguage: aLanguage [

	translator currentLanguage: aLanguage.
	context viewAreaActivator translateViewportBy: translator 
]

{ #category : #accessing }
PtyGuide >> user [
	^ user
]

{ #category : #accessing }
PtyGuide >> user: anObject [
	user := anObject
]

{ #category : #accessing }
PtyGuide >> viewArea [
	^viewArea
]

{ #category : #accessing }
PtyGuide >> viewArea: aViewAreaPresenter [
	viewArea := aViewAreaPresenter
]

{ #category : #'task execution' }
PtyGuide >> waitUserAction [
]
