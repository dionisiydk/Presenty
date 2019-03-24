Class {
	#name : #PtyShowRestrictedListTask,
	#superclass : #PtySimpleShowListTask,
	#instVars : [
		'itemsCount'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #execution }
PtyShowRestrictedListTask >> createItemPresenters [ 
		
	| target |
	target := items readStream next: itemsCount.
	^target collect: [ :each | itemPresenterFactory presenterOn: each for: self ]
]

{ #category : #execution }
PtyShowRestrictedListTask >> createListPresenter [ 
	listPresenter := PtyPresentersDecorator on: itemPresenters
]

{ #category : #'initialize-release' }
PtyShowRestrictedListTask >> initialize [ 
	super initialize.
	
	itemsCount := 5
]

{ #category : #accessing }
PtyShowRestrictedListTask >> itemsCount [
	^ itemsCount
]

{ #category : #accessing }
PtyShowRestrictedListTask >> itemsCount: anObject [
	itemsCount := anObject
]

{ #category : #'morphic menu' }
PtyShowRestrictedListTask >> populateSettingsMenu: aMenu for: aPrototype [
	super populateSettingsMenu: aMenu for: aPrototype.
	aMenu 
		add: 'change items count (' , itemsCount asString , ')' 
		target: (aPrototype proxyForSample: self) 
		action: #requestItemsCount
]

{ #category : #'morphic menu' }
PtyShowRestrictedListTask >> requestItemsCount [

	| countString |
	countString := UIManager default 
		request: 'Set items count per page' translated
		initialAnswer: itemsCount asString
		centerAt: Sensor cursorPoint.
	
	countString ifNil: [^self].
	countString asNumber.
	
	itemsCount := countString asNumber.
	
]
