Class {
	#name : #PtyItemsListTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-ShowListTasks'
}

{ #category : #running }
PtyItemsListTaskTests >> taskClass [ 
	^PtyItemsListTask 
]

{ #category : #testing }
PtyItemsListTaskTests >> testKindOfSuperclassTaskWithEqualItemsName [

	| actual |
	task itemsName: 'test item name'.

	actual := task isKindOfTask: (PtyItemsListTask new itemsName: 'test item name' copy).
	
	actual should be: true
]

{ #category : #testing }
PtyItemsListTaskTests >> testNotKindOfSuperclassTaskWithDifferentItemsName [

	| actual |
	task itemsName: 'test item name'.

	actual := task isKindOfTask: (PtyItemsListTask new itemsName: 'different item name').
	
	actual should be: false
]

{ #category : #testing }
PtyItemsListTaskTests >> testNotSimilarToTaskWithDifferentItemsName [

	| actual |
	task itemsName: 'test item name'.

	actual := task isSimilarTo: (self taskClass new itemsName: 'different item name').
	
	actual should be: false
]

{ #category : #testing }
PtyItemsListTaskTests >> testSimilarToTaskWithEqualItemsName [

	| actual |
	task itemsName: 'test item name'.

	actual := task isSimilarTo: (self taskClass new itemsName: 'test item name' copy).
	
	actual should be: true
]
