Class {
	#name : #PtyItemsPageTests,
	#superclass : #TestCase,
	#instVars : [
		'page'
	],
	#category : #'PresentyTests-ShowListTasks'
}

{ #category : #running }
PtyItemsPageTests >> setUp [
	super setUp.
	
	page := PtyItemsPage new.
]

{ #category : #tests }
PtyItemsPageTests >> testAddingItem [

	page add: #item.
	
	page contents first should be: #item
	
	
]

{ #category : #tests }
PtyItemsPageTests >> testCreationByDevisionCollection [

	| pages |
	pages := #(1 2 3 4 5) divideForPagesWithSize: 2.
	
	pages should haveSize: 3.
	
	pages first number should equal: 1.
	pages first contents should equal: #(1 2) asOrderedCollection.	

	pages second number should equal: 2.
	pages second contents should equal: #(3 4) asOrderedCollection.

	pages last number should equal: 3.
	pages last contents should equal: #(5) asOrderedCollection.
]

{ #category : #tests }
PtyItemsPageTests >> testGettingItemsCount [

	page contents: #(1 2).
	
	page itemsCount should equal: 2
	
	
]

{ #category : #tests }
PtyItemsPageTests >> testHasEmptyContentsByDefault [

	page contents should be isEmpty
]
