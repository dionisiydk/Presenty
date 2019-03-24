Class {
	#name : #PtyNamedItemListPrototypeContext,
	#superclass : #PtyNamedPrototypeContext,
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyNamedItemListPrototypeContext class >> basedOn: anItemsListTask [

	^self named: anItemsListTask itemsName 
]

{ #category : #testing }
PtyNamedItemListPrototypeContext class >> isActiveFor: anObject [

	(anObject isKindOf: PtyItemsListTask) ifFalse: [^false].

	^anObject itemsName notNil
	
	
]
