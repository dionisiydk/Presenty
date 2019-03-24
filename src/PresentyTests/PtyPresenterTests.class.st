Class {
	#name : #PtyPresenterTests,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'guide'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyPresenterTests >> setUp [ 
	super setUp.
	
	guide := Mock new.
	presenter := PtyPresenter new.
	presenter guide: guide
]

{ #category : #tests }
PtyPresenterTests >> testAddingUserAction [

	[:userActionSource :userAction |
		[presenter addUserAction: userActionSource]
			should strictly satisfy: 
		[userActionSource asUserAction willReturn: userAction.
		userAction presenter: presenter].
	
		presenter userActions should haveSize: 1.
		presenter userActions should include: userAction.
	
	] runWithMocks  
]

{ #category : #tests }
PtyPresenterTests >> testAlwaysCanSupplyIinstancesOfPrototypes [

	(presenter canBePrototypeInContextOf: nil) should be: true
]

{ #category : #tests }
PtyPresenterTests >> testConnectingUserActions [

	[:userAction1 :userAction2  | 
		presenter userActions add: userAction1; add: userAction2.
		
		[presenter connectUserActionsBy: #uiSettings ] 
			should strictly satisfy: 
		[userAction1 connectToPresenterBy: #uiSettings.
		userAction2 connectToPresenterBy: #uiSettings].
			
	] runWithMocks
]

{ #category : #tests }
PtyPresenterTests >> testConvertionToUserRequestTask [

	| actual |
	actual := presenter asUserRequestTask.
	
	actual should beInstanceOf: PtyUserRequestTask.
	actual presenter should be: presenter
	
]

{ #category : #tests }
PtyPresenterTests >> testCreationView [

	[ :uiSettings :view | 
		[presenter createViewBy: uiSettings ] 
			should strictly satisfy: 
		[(uiSettings appropriateViewFor: presenter) willReturn: view.
		view ptyLoadResourcesBy: guide.
		view translateSubViewsBy: guide].
	
		presenter view should be: view 
	] runWithMocks
]

{ #category : #tests }
PtyPresenterTests >> testGettingContextWhenItAbsent [

	[:parent |
		presenter context: nil.
		presenter parent: parent.
		
		[presenter context should be: #context]
			should strictly satisfy: 
		[parent context willReturn: #context]
	] runWithMocks 
]

{ #category : #tests }
PtyPresenterTests >> testGettingContextWhenItExists [

	presenter context: #context.
	
	presenter context should be: #context
]

{ #category : #tests }
PtyPresenterTests >> testGettingParentWithStyleWhenParentAbsent [

	presenter parent: nil.
	
	presenter findParentWithStyle should be: nil
]

{ #category : #tests }
PtyPresenterTests >> testGettingParentWithStyleWhenParentHasNoStyle [

	[:parent |
		presenter parent: parent.
		
		[presenter findParentWithStyle should be: #result]
			should strictly satisfy: 
		[parent hasStyle willReturn: false.
		parent findParentWithStyle willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyPresenterTests >> testGettingParentWithStyleWhenParentHasStyle [

	[:parent |
		presenter parent: parent.
		
		[presenter findParentWithStyle should be: parent]
			should strictly satisfy: 
		[parent hasStyle willReturn: true]
	] runWithMocks 
]

{ #category : #tests }
PtyPresenterTests >> testGettingParentsChain [

	| actual |
	[ :parent :praParent | 
	presenter parent: parent.
	[actual := presenter parentsChain] 
		should strictly satisfy: 
	[parent parent willReturn: praParent.
	praParent parent willReturn: nil].
	actual first should be: parent.
	actual last should be: praParent
	] runWithMocks
]

{ #category : #tests }
PtyPresenterTests >> testGettingPrototypeGroupNameWhenNameAbsent [

	presenter name: nil.
	presenter prototypeContextName should equal: presenter class name
]

{ #category : #tests }
PtyPresenterTests >> testGettingPrototypeGroupNameWhenNameExists [

	presenter name: 'presenterName'.
	presenter prototypeContextName should equal: 'presenterName'
]

{ #category : #tests }
PtyPresenterTests >> testHasEmptyUserActionsByDefault [

	presenter userActions should be isEmpty	
]

{ #category : #tests }
PtyPresenterTests >> testHasNoNameByDefault [

	presenter name should be: nil
]

{ #category : #tests }
PtyPresenterTests >> testHasNotStyleWhenItAbsent [

	presenter style: nil.
	
	presenter hasStyle should be: false
]

{ #category : #tests }
PtyPresenterTests >> testHasStyleWhenItExists [

	presenter style: #some.
	
	presenter hasStyle should be: true
]

{ #category : #tests }
PtyPresenterTests >> testSettingContextOnce [

	presenter context: #context.
	
	presenter context should be: #context
]

{ #category : #tests }
PtyPresenterTests >> testSettingContextTwice [

	presenter context: #context.
	
	presenter context: #anotherContext.
	
	presenter context should be: #context
]

{ #category : #tests }
PtyPresenterTests >> testShowItem [

	[:item :view |
		presenter view: view. 
		[presenter showItem: item] 
			should strictly satisfy: 
		[item parent: presenter.
		guide preparePresenter: item.
		item view willReturn: #itemView.
		view add: #itemView].
	] runWithMocks
]

{ #category : #tests }
PtyPresenterTests >> testShowItemOnPanel [

	[ :item :panel |
		[presenter showItem: item onPanel: panel] 
			should strictly satisfy: 
		[item parent: presenter.
		guide preparePresenter: item.
		item view willReturn: #itemView.
		panel add: #itemView].
	] runWithMocks
]

{ #category : #tests }
PtyPresenterTests >> testShowItemOnPanelByName [

	[ :item :view :panel |
		presenter view: view.
		
		[presenter showItem: item on: #panelName] 
			should strictly satisfy: 
		[(view panelNamed: #panelName) willReturn: panel; useArbitrarily.
		item parent: presenter.
		guide preparePresenter: item.
		item view willReturn: #itemView.
		panel add: #itemView].
	] runWithMocks
]
