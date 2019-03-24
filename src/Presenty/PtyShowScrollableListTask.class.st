Class {
	#name : #PtyShowScrollableListTask,
	#superclass : #PtyShowFullListTask,
	#category : #'Presenty-ShowListTasks'
}

{ #category : #execution }
PtyShowScrollableListTask >> showListPresenter [
	
	| scroller |
	scroller := listPresenter asScrollablePanel.
	^user lookAt: scroller and: [scroller update].

]
