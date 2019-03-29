Class {
	#name : #PtyItemsRequestTask,
	#superclass : #PtyItemsListTask,
	#instVars : [
		'showSingleItem',
		'needsSearch'
	],
	#category : #'Presenty-ItemSelectionTasks'
}

{ #category : #body }
PtyItemsRequestTask >> activateItemSearch [
	
	worker executeTask: ((PtySearchItemTask forItems: items of: itemsName)
							 asModalTaskFor: context)
]

{ #category : #body }
PtyItemsRequestTask >> addSearchButton [ 

	worker addUserAction: (PtySearchItemTask forItems: items of: itemsName).
	
]

{ #category : #body }
PtyItemsRequestTask >> body [

	| listTask item |
	items ifEmpty: [user warn: 'No items'.
		^user stopCurrentTask ].

	items size = 1 & showSingleItem not ifTrue: [^items anyOne].
	
	needsSearch & (items size > 1) ifTrue: [self addSearchButton].

	listTask := (PtyItemsSelectionTask forItems: items of: itemsName).

	item := worker requestUserFor: listTask.
	
	^item.
	
]

{ #category : #testing }
PtyItemsRequestTask >> canBePrototypeInContextOf: aTask [
	^true
]

{ #category : #'initialize-release' }
PtyItemsRequestTask >> initialize [ 
	super initialize.
	
	needsSearch := false.
	showSingleItem := true.
]

{ #category : #accessing }
PtyItemsRequestTask >> needsSearch [
	^ needsSearch
]

{ #category : #accessing }
PtyItemsRequestTask >> needsSearch: anObject [
	needsSearch := anObject
]

{ #category : #'morphic menu' }
PtyItemsRequestTask >> populateSettingsMenu: aMenu for: aPrototype [
	super populateSettingsMenu: aMenu for: aPrototype.
	
	aMenu
		addToggle: 'show single item' translated
		target:  (aPrototype proxyForSample: self)
		selector: #showSingleItem:
		getStateSelector:  #showSingleItem
		argumentList: {showSingleItem not}.
	
	aMenu
		addToggle: 'needs search' translated
		target:  (aPrototype proxyForSample: self)
		selector: #needsSearch:
		getStateSelector:  #needsSearch
		argumentList: {needsSearch not}
]

{ #category : #accessing }
PtyItemsRequestTask >> showSingleItem [
	^ showSingleItem
]

{ #category : #accessing }
PtyItemsRequestTask >> showSingleItem: anObject [

	showSingleItem := anObject
]
