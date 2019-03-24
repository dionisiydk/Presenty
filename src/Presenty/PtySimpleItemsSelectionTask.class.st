Class {
	#name : #PtySimpleItemsSelectionTask,
	#superclass : #PtyItemsSelectionTask,
	#category : #'Presenty-ItemSelectionTasks'
}

{ #category : #execution }
PtySimpleItemsSelectionTask >> body [

	| item |

	item := user lookAtList: items of: itemsName.

	^item
]

{ #category : #testing }
PtySimpleItemsSelectionTask >> canBePrototypeInContextOf: aTask [
	^true
]
