Class {
	#name : #PtyShowListWithPagesTask,
	#superclass : #PtyShowListTask,
	#instVars : [
		'pageSize'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #execution }
PtyShowListWithPagesTask >> body [

	| pages page item |
	pages := items divideForPagesWithSize: pageSize.	
	
	page := user select: 'ItemsPage' from: pages. 

	item := user select: itemsName from: page contents.

	^item
]

{ #category : #'initialize-release' }
PtyShowListWithPagesTask >> initialize [ 
	super initialize.
	
	pageSize := 5
]

{ #category : #accessing }
PtyShowListWithPagesTask >> pageSize [
	^ pageSize
]

{ #category : #accessing }
PtyShowListWithPagesTask >> pageSize: anObject [
	pageSize := anObject
]

{ #category : #'morphic menu' }
PtyShowListWithPagesTask >> populateSettingsMenu: aMenu for: aPrototype [
	super populateSettingsMenu: aMenu for: aPrototype.
	
	aMenu 
		add: 'change items count (' , pageSize asString , ')' 
		target: (aPrototype proxyForSample: self) 
		action: #requestItemsCount
]

{ #category : #'morphic menu' }
PtyShowListWithPagesTask >> requestItemsCount [

	| countString |
	countString := UIManager default 
		request: 'Set items count per page' translated
		initialAnswer: pageSize asString
		centerAt: Sensor cursorPoint.
	
	countString ifNil: [^self].
	countString asNumber.
	
	pageSize := countString asNumber.
	
]
