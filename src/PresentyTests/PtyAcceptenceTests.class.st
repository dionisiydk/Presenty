Class {
	#name : #PtyAcceptenceTests,
	#superclass : #TestCase,
	#instVars : [
		'guide',
		'user',
		'viewArea',
		'baseView',
		'userRequest'
	],
	#category : #'PresentyTests-Acceptance'
}

{ #category : #helpers }
PtyAcceptenceTests >> addTask: sampleTask asPrototypeFor: requestedTask [
	self withPrototypeOf: requestedTask do: [:p | p sample: sampleTask ]
	
	
]

{ #category : #helpers }
PtyAcceptenceTests >> addTaskPrototype: aTask [
	
	self withPrototypeOf: aTask do: [:p | p sample: aTask]
	
	
]

{ #category : #helpers }
PtyAcceptenceTests >> assert: aViewAreaPresenter containsLabel: labelName [
	aViewAreaPresenter body presenter should beInstanceOf: PtyTextLabelPresenter.
	aViewAreaPresenter body presenter model should equal: labelName.
 



	

]

{ #category : #helpers }
PtyAcceptenceTests >> assert: aViewAreaPresenter containsListWith: anArray [
	| items model presenter |
	aViewAreaPresenter should beInstanceOf: PtyViewAreaPresenter.
	aViewAreaPresenter body ifNotNilDo: [:i | presenter := i presenter].
	presenter ifNil: [presenter := aViewAreaPresenter items first presenter body presenter].
	presenter should beInstanceOf: PtyPresentersDecorator.

	items := presenter model collect: [:each | 
		model := each model first model. 
		[model isKindOf: PtyPresenter] whileTrue: [model := model model].
		model].

	items should equal: anArray
 



	

]

{ #category : #helpers }
PtyAcceptenceTests >> executeTask: taskSource [

	guide executeTask: [
		[guide requestUserFor: taskSource asTask] on: PtyUserRequest do: [:r | 
			userRequest := r.
			PtyUserRequestStub signal.
		]
	] asTask asNewApplication.

	[guide taskController process isTerminated] whileFalse: [
		World doOneCycle].
	userRequest ifNil: [self error: 'No user request happen'].
	guide showViewAreaBy: userRequest viewAreaActivator.
	 
	viewArea := guide viewArea.
	baseView := guide context viewAreaActivator rootActivator baseArea view.
	
	baseView should not be: nil



	

]

{ #category : #helpers }
PtyAcceptenceTests >> findListItemWith: anObject [
	| items model targets currentAreaItem targetPresenter |
	targets := viewArea items,  {viewArea body}.
	
	[targets isEmpty] whileFalse: [
		currentAreaItem := targets first.
		currentAreaItem presenter class = PtyViewAreaPresenter 
			ifTrue: [targets addAll: currentAreaItem presenter items.
				currentAreaItem presenter body ifNotNil: [targets add: currentAreaItem presenter body]]
			ifFalse: [currentAreaItem presenter class = PtyPresentersDecorator ifTrue: [
				currentAreaItem presenter model do: [:eachItem | 
					targetPresenter :=	eachItem model first.
					model := targetPresenter model. 
					[model isKindOf: PtyPresenter] whileTrue: [
						targetPresenter := model.
						model := model model].
					model = anObject ifTrue: [
						^targetPresenter parent
					]]
			]].
		targets removeFirst
		].	

	^self error: 'There is no list item with ', anObject asString 



	

]

{ #category : #helpers }
PtyAcceptenceTests >> selectListItemWith: anObject [

	| item |
	item := self findListItemWith: anObject.
	
	item userActions first execute.
	[guide taskController process isTerminated] whileFalse: [
		World doOneCycle].
	viewArea := guide viewArea.	
]

{ #category : #running }
PtyAcceptenceTests >> setUp [
	| prototype activator runner |
	super setUp.
	 
	guide := PtyGuide new.
	user := guide user.
	userRequest := nil.
	runner := PtyRunApplicationTask new.
	runner activationStrategy areaActivator: PtyViewAreaStubActivator new.
	self addTaskPrototype: runner
	
	
]

{ #category : #tests }
PtyAcceptenceTests >> testItemsNavigationTask [

	| item navigation listTask |
	
	navigation := PtyItemsNavigationTask new.
	navigation needsFirstSelection: true.
	self addTask: navigation asPrototypeFor: PtyItemsSelectionTask new.
	self addTask: PtyShowFullListTask new asPrototypeFor: PtyShowListTask new.
	self addTask: PtyForkTask new asPrototypeFor: (PtyAddExtraTask on: PtyTask new).
	
	self executeTask: [		

		item := user select: 'TestListItem' from: #(firstItem lastItem).
		user warn: item asString.				
	].
 
	item should be: #firstItem.
	self assert: viewArea containsLabel: 'firstItem'.
	viewArea items should haveSize: 1.
	self assert: viewArea items first presenter containsListWith: #(firstItem lastItem).
 



	

]

{ #category : #tests }
PtyAcceptenceTests >> testShowWarningTask [

	self executeTask: [		
		user warn: 'test warning'.				
	].
 
	self assert: viewArea containsLabel: 'test warning'



	

]

{ #category : #tests }
PtyAcceptenceTests >> testTwoCascadeItemsNavigationTasks [

	| item navigation item2 |
	
	navigation := PtyItemsNavigationTask new.
	navigation needsFirstSelection: true.
	self addTask: navigation asPrototypeFor: PtyItemsSelectionTask new.
	self addTask: PtyShowFullListTask new asPrototypeFor: PtyShowListTask new.
	self addTask: PtyForkTask new asPrototypeFor: (PtyAddExtraTask on: PtyTask new).
	
	self executeTask: [		

		item := user select: 'TestListItem' from: #(firstItem lastItem).
		item2 := user select: 'TestListItem2' from: #(firstItem2 lastItem2).
		
		user warn: item, item2.
	].
 
	self assert: viewArea containsLabel: 'firstItemfirstItem2'.
	viewArea items should haveSize: 2.
	self assert: viewArea items first presenter containsListWith: #(firstItem lastItem).
	self assert: viewArea items last presenter containsListWith: #(firstItem2 lastItem2). 


	

]

{ #category : #tests }
PtyAcceptenceTests >> testTwoCascadeItemsNavigationTasksAfterFirstItemSelected [

	| item navigation item2 |
	
	navigation := PtyItemsNavigationTask new.
	navigation needsFirstSelection: true.
	self addTask: navigation asPrototypeFor: PtyItemsSelectionTask new.
	self addTask: PtyShowFullListTask new asPrototypeFor: PtyShowListTask new.
	self addTask: PtyForkTask new asPrototypeFor: (PtyAddExtraTask on: PtyTask new).
	
	self executeTask: [		

		item := user select: 'TestListItem' from: #(firstItem lastItem).
		item2 := user select: 'TestListItem2' from: #(firstItem2 lastItem2).
		
		user warn: item, item2.
	].

	self selectListItemWith: #lastItem.
	
	self assert: viewArea containsLabel: 'lastItemfirstItem2'.
	viewArea items should haveSize: 2.
	self assert: viewArea items first presenter containsListWith: #(firstItem lastItem).
	self assert: viewArea items last presenter containsListWith: #(firstItem2 lastItem2). 


	

]

{ #category : #tests }
PtyAcceptenceTests >> testTwoForkedItemsNavigationTasks [

	| item navigation item2 |
	
	navigation := PtyItemsNavigationTask new.
	navigation needsFirstSelection: false.
	self addTask: navigation asPrototypeFor: PtyItemsSelectionTask new.
	self addTask: PtyShowFullListTask new asPrototypeFor: PtyShowListTask new.
	self addTask: PtyForkTask new asPrototypeFor: (PtyAddExtraTask on: PtyTask new).
	
	self executeTask: [		

		guide addTask: [	
			item := user select: 'TestListItem' from: #(firstItem lastItem).
			user warn: item.
		].
		guide addTask: [
			item2 := user select: 'TestListItem2' from: #(firstItem2 lastItem2).
			user warn: item2
		].
		
		user warn: 'two forked tasks'.
	].

	self assert: viewArea containsLabel: 'two forked tasks'.
	viewArea items should haveSize: 2.
	self assert: viewArea items first presenter containsListWith: #(firstItem lastItem).
	self assert: viewArea items last presenter containsListWith: #(firstItem2 lastItem2). 


	

]

{ #category : #tests }
PtyAcceptenceTests >> testTwoForkedItemsNavigationTasksAfterFirstForkedItemSelected [

	| item navigation item2 |
	
	navigation := PtyItemsNavigationTask new.
	navigation needsFirstSelection: false.
	self addTask: navigation asPrototypeFor: PtyItemsSelectionTask new.
	self addTask: PtyShowFullListTask new asPrototypeFor: PtyShowListTask new.
	self addTask: PtyForkTask new asPrototypeFor: (PtyAddExtraTask on: PtyTask new).
	
	self executeTask: [		

		guide addTask: [	
			item := user select: 'TestListItem' from: #(firstItem lastItem).
			user warn: item.
		].
		guide addTask: [
			item2 := user select: 'TestListItem2' from: #(firstItem2 lastItem2).
			user warn: item2
		].
		
		user warn: 'two forked tasks'.
	].

	self selectListItemWith: #lastItem.
	
	self assert: viewArea containsLabel: 'lastItem'.
	viewArea items should haveSize: 2.
	self assert: viewArea items first presenter containsListWith: #(firstItem lastItem).
	self assert: viewArea items last presenter containsListWith: #(firstItem2 lastItem2). 


	

]

{ #category : #tests }
PtyAcceptenceTests >> testTwoForkedItemsNavigationTasksAfterLastForkedItemSelected [

	| item navigation item2 |
	
	navigation := PtyItemsNavigationTask new.
	navigation needsFirstSelection: false.
	self addTask: navigation asPrototypeFor: PtyItemsSelectionTask new.
	self addTask: PtyShowFullListTask new asPrototypeFor: PtyShowListTask new.
	self addTask: PtyForkTask new asPrototypeFor: (PtyAddExtraTask on: PtyTask new).
	
	self executeTask: [		

		guide addTask: [	
			item := user select: 'TestListItem' from: #(firstItem lastItem).
			user warn: item.
		].
		guide addTask: [
			item2 := user select: 'TestListItem2' from: #(firstItem2 lastItem2).
			user warn: item2
		].
		
		user warn: 'two forked tasks'.
	].

	self selectListItemWith: #lastItem2.
	
	self assert: viewArea containsLabel: 'lastItem2'.
	viewArea items should haveSize: 2.
	self assert: viewArea items first presenter containsListWith: #(firstItem lastItem).
	self assert: viewArea items last presenter containsListWith: #(firstItem2 lastItem2). 


	

]

{ #category : #helpers }
PtyAcceptenceTests >> withPrototypeOf: aTask do: aBlock [
	| prototype |
	prototype := guide uiSettings taskPrototypes prototypeFor: aTask.
	prototype assignToCollection.
	aBlock value: prototype 
	
	
]
