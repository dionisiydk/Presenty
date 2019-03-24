Class {
	#name : #PtyItemsListTask,
	#superclass : #PtyTask,
	#instVars : [
		'items',
		'itemsName'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'instance creation' }
PtyItemsListTask class >> forItems: itemsCollection of: itemsClass [

	^self new 
		items: itemsCollection;
		itemsName: itemsClass
]

{ #category : #'instance creation' }
PtyItemsListTask class >> on: itemsArray [

	^self forItems: itemsArray of: self defaultItemsName
]

{ #category : #'instance creation' }
PtyItemsListTask class >> on: itemsArray named: aString [

	^(self on: itemsArray)
		name: aString 
]

{ #category : #testing }
PtyItemsListTask >> isKindOfTask: aTask [ 

	(super isKindOfTask: aTask) ifFalse: [^false].
	
	(aTask isKindOf: PtyItemsListTask) ifFalse: [^true].
	
	^itemsName = aTask itemsName  
]

{ #category : #testing }
PtyItemsListTask >> isSimilarTo: aTask [ 

	(super isSimilarTo: aTask) ifFalse: [^false].
	
	^itemsName = aTask itemsName  
]

{ #category : #accessing }
PtyItemsListTask >> items [
	^ items
]

{ #category : #accessing }
PtyItemsListTask >> items: anObject [
	items := anObject asPtyModel 
]

{ #category : #accessing }
PtyItemsListTask >> itemsName [
	^ itemsName
]

{ #category : #accessing }
PtyItemsListTask >> itemsName: anObject [
	itemsName := anObject
]

{ #category : #printing }
PtyItemsListTask >> printDetailsOn: aStream [

	name isNil & itemsName isNil ifTrue: [^self].
	
	aStream nextPut: $(.
	
	name ifNotNil: [aStream nextPutAll: name; nextPutAll: ', '].
	itemsName ifNotNil: [aStream nextPutAll: itemsName].
	
	aStream nextPut: $)
	
]

{ #category : #accessing }
PtyItemsListTask >> readSampleProperitiesFrom: requestedListTask [
	super readSampleProperitiesFrom: requestedListTask.
	
	itemsName := requestedListTask itemsName 
]
