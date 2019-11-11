Class {
	#name : #PtySimpleShowListTask,
	#superclass : #PtyShowListTask,
	#instVars : [
		'listPresenter',
		'itemPresenters'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #execution }
PtySimpleShowListTask >> body [
	| item |
	items on: PtyItemAdded send: #itemAdded to: self.
	items on: PtyItemRemoved send: #itemRemoved: to: self.
	items on: PtyListCleared send: #listCleared to: self.
	
	itemPresenters := self createItemPresenters.
	itemPresenters := itemPresenters collect: [ :each | PtyPresentersDecorator named: 'listItem' on: {each} ].
	itemPresenters doWithIndex: [ :each :i | 
		each addUserAction: (PtyReturnValueFromPresenterTask from: each with: (items itemAt: i)) ].
	self createListPresenter.
	item := self showListPresenter.
	^ item
]

{ #category : #execution }
PtySimpleShowListTask >> createItemPresenters [
	^ items collect: [ :each | itemPresenterFactory presenterOn: each for: self ]
]

{ #category : #execution }
PtySimpleShowListTask >> createListPresenter [
	self subclassResponsibility 
]

{ #category : #execution }
PtySimpleShowListTask >> deselectItem: anObject [

	| i |
	i := items indexOf: anObject.

	i <= 0 ifTrue: [^self].
	(itemPresenters at: i) view ifNil: [^self].
	workplace show: (itemPresenters at: i) withStyle: #deselected
]

{ #category : #execution }
PtySimpleShowListTask >> itemAdded [
	 
	| itemPresenter |
	
	itemPresenter := itemPresenterFactory presenterOn: items last for: self.

	listPresenter model add: itemPresenter.
]

{ #category : #execution }
PtySimpleShowListTask >> itemRemoved: ann [

	listPresenter model removeAt: ann itemIndex
]

{ #category : #execution }
PtySimpleShowListTask >> listCleared [
	 
	listPresenter model removeAll
]

{ #category : #execution }
PtySimpleShowListTask >> selectItem: anObject [

	| i |
	i := items indexOf: anObject.

	i <= 0 ifTrue: [^self].
	(itemPresenters at: i) view ifNil: [^self].
	workplace show: (itemPresenters at: i) withStyle: #selected
]

{ #category : #execution }
PtySimpleShowListTask >> showListPresenter [ 

	^user lookAt: listPresenter
]
