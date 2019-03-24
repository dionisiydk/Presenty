Class {
	#name : #PtyListModel,
	#superclass : #Announcer,
	#instVars : [
		'list'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'instance creation' }
PtyListModel class >> on: aCollection [

	^self new 
		list: aCollection 
]

{ #category : #accessing }
PtyListModel >> add: anObject [

	list add: anObject.
	
	self announce: PtyItemAdded 
]

{ #category : #convertion }
PtyListModel >> asPtyModel [ 

	^self

	
]

{ #category : #accessing }
PtyListModel >> clear [ 

	list removeAll.
	
	self announce: PtyListCleared
]

{ #category : #accessing }
PtyListModel >> doesNotUnderstand: aMessage [

	(list respondsTo: aMessage selector)
		ifTrue: [^aMessage sendTo: list].
		
	super doesNotUnderstand: aMessage 
	
]

{ #category : #'initialize-release' }
PtyListModel >> initialize [ 
	super initialize.
	
	list := OrderedCollection new
]

{ #category : #accessing }
PtyListModel >> itemAt: index [

	^list at: index
]

{ #category : #accessing }
PtyListModel >> list [
	^ list
]

{ #category : #accessing }
PtyListModel >> list: anObject [
	list := anObject
]

{ #category : #accessing }
PtyListModel >> remove: anObject [

	| index |
	index := list indexOf: anObject.
	
	list remove: anObject.
	
	self announce: (PtyItemRemoved item: anObject index: index)
]

{ #category : #accessing }
PtyListModel >> size [ 
	^list size
]
