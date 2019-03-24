Class {
	#name : #PtyShowFullListTask,
	#superclass : #PtySimpleShowListTask,
	#category : #'Presenty-ShowListTasks'
}

{ #category : #execution }
PtyShowFullListTask >> createListPresenter [
	listPresenter := PtyPresentersDecorator on: itemPresenters asOrderedCollection
]
