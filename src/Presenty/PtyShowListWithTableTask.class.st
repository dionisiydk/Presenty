Class {
	#name : #PtyShowListWithTableTask,
	#superclass : #PtyShowListTask,
	#instVars : [
		'columns',
		'columnsSpec'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #configuration }
PtyShowListWithTableTask >> addColumnForAspect: aspectsPath [

	columnsSpec add: aspectsPath
]

{ #category : #testing }
PtyShowListWithTableTask >> allowSeparateItems [
	^false
]

{ #category : #execution }
PtyShowListWithTableTask >> body [

	| item listTask |
	self showHeader.

	[^user lookAtList: items of: itemsName] 
		on: (PtyTaskConfigurationRequest for: PtyShowListTask ofItems: itemsName) 
		do: [:request | 
			request task itemPresenterFactory: self createRowFactory.
			request resume		
		]
]

{ #category : #accessing }
PtyShowListWithTableTask >> collectColumns [

	| title |
	^columnsSpec collect: [:aspectPath | 
		
		title := ' ' join: aspectPath.
		 
		PtyTableColumn title: title block: [:p | (p ptyAspect: aspectPath) value ifNil: ['']].
		
		]
]

{ #category : #accessing }
PtyShowListWithTableTask >> columns [ 

	^columns ifNil: [columns := self collectColumns]
]

{ #category : #accessing }
PtyShowListWithTableTask >> columns: anObject [
	^ columns := anObject
]

{ #category : #execution }
PtyShowListWithTableTask >> createHeader [
	
	| header |
	header := PtyTableRowPresenter on: nil withStyle: itemsName asString, 'Header'.
	header columns: self headerColumns.
	
	^header
]

{ #category : #execution }
PtyShowListWithTableTask >> createRowFactory [

	| factory |
	factory := PtyTableRowFactory withColumns: self columns.
	^itemPresenterFactory convertTo: factory
]

{ #category : #execution }
PtyShowListWithTableTask >> createTableBody [

	| factory rows |
	factory := self createRowFactory.
	
	rows := items collect: [:each | factory presenterOn: each for: self].
	
	^PtyPresentersDecorator on: rows
]

{ #category : #execution }
PtyShowListWithTableTask >> headerColumns [
	^self columns collect: [:each | PtyTableColumn title: each title block: [:m | each]]
	
]

{ #category : #'initialize-release' }
PtyShowListWithTableTask >> initialize [ 
	super initialize.
	
	columnsSpec := OrderedCollection new.	
]

{ #category : #'morphic menu' }
PtyShowListWithTableTask >> populateSettingsMenu: aMenu for: aPrototype [

	| subMenu columnMenu |
	super populateSettingsMenu: aMenu for: aPrototype.
	aMenu add: 'add column' translated target: (aPrototype proxyForSample: self) 
		action: #requestNewColumn.
	
	columnsSpec ifEmpty: [^self].
	
	subMenu := MenuMorph new defaultTarget: self.
	columnsSpec do: [:each |		
		columnMenu := MenuMorph new defaultTarget: self.
		columnMenu
			add: 'remove column' translated
			target: self
			selector: #removeColumnWithAspect:  
			argument: each.
		columnMenu
			add: 'push up column' translated
			target: self
			selector: #pushUpColumnWithAspect:  
			argument: each.
		columnMenu
			add: 'pull down column' translated
			target: self
			selector: #pullDownColumnWithAspect:  
			argument: each.
		subMenu add: (' ' join: each) subMenu: columnMenu.
		].

	aMenu add: 'columns' translated subMenu: subMenu.
]

{ #category : #'morphic menu' }
PtyShowListWithTableTask >> pullDownColumnWithAspect: aspectPath [ 

	| afterItem |
	afterItem := columnsSpec after: aspectPath ifAbsent: [^self].

	columnsSpec remove: aspectPath.
	columnsSpec add: aspectPath after: afterItem
]

{ #category : #'morphic menu' }
PtyShowListWithTableTask >> pushUpColumnWithAspect: aspectPath [ 

	| beforeItem |
	beforeItem := columnsSpec before: aspectPath ifAbsent: [^self].

	columnsSpec remove: aspectPath.
	columnsSpec add: aspectPath before: beforeItem
]

{ #category : #'morphic menu' }
PtyShowListWithTableTask >> removeColumnWithAspect: aspectPath [ 
	columnsSpec remove: aspectPath 
]

{ #category : #'morphic menu' }
PtyShowListWithTableTask >> requestNewColumn [

	| pathString |
	pathString := UIManager default 
		request: 'New column aspect path' translated
		initialAnswer: 'input aspects path by spaces'
		centerAt: Sensor cursorPoint.
	
	pathString ifNil: [^self].
	
	self addColumnForAspect: ((' ' split: pathString) collect: [:each | each asSymbol])
]

{ #category : #execution }
PtyShowListWithTableTask >> showHeader [
	
	| header |
	header := self createHeader.
	
	workplace add: header toViewAreaOn: itemsName asString, 'TableHeader'

]
