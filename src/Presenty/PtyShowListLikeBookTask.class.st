Class {
	#name : #PtyShowListLikeBookTask,
	#superclass : #PtySimpleShowListTask,
	#category : #'Presenty-ShowListTasks'
}

{ #category : #execution }
PtyShowListLikeBookTask >> createListPresenter [ 
	listPresenter := PtyScrollableListDecorator on: itemPresenters
]
