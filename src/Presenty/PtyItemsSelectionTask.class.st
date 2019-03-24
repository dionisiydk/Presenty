Class {
	#name : #PtyItemsSelectionTask,
	#superclass : #PtyItemsListTask,
	#category : #'Presenty-ItemSelectionTasks'
}

{ #category : #accessing }
PtyItemsSelectionTask class >> createPreferredInstanceBy: aTaskPrototypeFactory [

	^aTaskPrototypeFactory preferredItemsSelectionTask
]

{ #category : #testing }
PtyItemsSelectionTask >> allowChangeParentViewAreaState [
	^false
]
