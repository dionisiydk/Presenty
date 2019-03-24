Class {
	#name : #PtyUISettingsTests,
	#superclass : #TestCase,
	#instVars : [
		'settings'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyUISettingsTests >> setUp [
	super setUp.
	
	settings := PtyUISettings new
]

{ #category : #tests }
PtyUISettingsTests >> testCreationAppropriateTask [

	[:requestedTask :manager :prototype :newTask |
		settings taskPrototypes: manager.
		[(settings appropriateTaskLike: requestedTask inContextOf: #taskContext) should be: newTask]
			should strictly satisfy: 
		[requestedTask context: #taskContext.
		(manager prototypeFor: requestedTask) willReturn: prototype.
		prototype newInstance willReturn: newTask.
		newTask readFromSample: requestedTask.
		newTask prototype: prototype]
	
	] runWithMocks 
]

{ #category : #tests }
PtyUISettingsTests >> testCreationViewForPresenter [

	[:presenter |
		[settings createViewFor: presenter]
			should strictly satisfy: 
		[presenter createViewBy: settings.
		presenter connectUserActionsBy: settings].
	
	] runWithMocks 

]

{ #category : #tests }
PtyUISettingsTests >> testGettingAppropriateViewForPresenter [

	| context actual |
	[:viewPrototypes :prototype :view |
		settings viewPrototypes: viewPrototypes.
		
		[actual := settings appropriateViewFor: #presenter]
			should strictly satisfy: 
		[(viewPrototypes prototypeFor: #presenter) willReturn: prototype.
		prototype newInstance willReturn: view.
		(view buildContext: (Instance of: PtyViewBuildContext)) will: [:arg | context := arg]].
	
		context presenter should be: #presenter.
		context prototype should be: prototype.
		actual should be: view
	] runWithMocks 

]

{ #category : #tests }
PtyUISettingsTests >> testHasTaskPrototypesByDefault [

	| lookupBuilder |
	settings taskPrototypes should beInstanceOf: PtyPrototypesManager.
	lookupBuilder := settings taskPrototypes lookupBuilder.
	lookupBuilder prototypeFactory should beInstanceOf: PtyTaskPrototypeFactory
]

{ #category : #tests }
PtyUISettingsTests >> testHasUserActionPrototypesByDefault [

	| lookupBuilder |
	settings userActionPrototypes should beInstanceOf: PtyPrototypesManager.
	lookupBuilder := settings userActionPrototypes lookupBuilder.
	lookupBuilder prototypeFactory should beInstanceOf: PtyUserActionPrototypeFactory
]

{ #category : #tests }
PtyUISettingsTests >> testHasViewPrototypesByDefault [

	| lookupBuilder |
	settings viewPrototypes should beInstanceOf: PtyPrototypesManager.
	lookupBuilder := settings viewPrototypes lookupBuilder.
	lookupBuilder prototypeFactory should beInstanceOf: PtyViewPrototypeFactory 
]
