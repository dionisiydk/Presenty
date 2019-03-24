Class {
	#name : #PtyShowListTask,
	#superclass : #PtyItemsListTask,
	#instVars : [
		'itemPresenterFactory'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #accessing }
PtyShowListTask class >> createPreferredInstanceBy: aTaskPrototypeFactory [

	^aTaskPrototypeFactory preferredListTask
]

{ #category : #'initialize-release' }
PtyShowListTask >> defaultPresenterFactory [

	^PtyPresenterPreviewFactory new
]

{ #category : #'initialize-release' }
PtyShowListTask >> initialize [ 
	super initialize.
	
	itemPresenterFactory := self defaultPresenterFactory.
]

{ #category : #accessing }
PtyShowListTask >> itemPresenterFactory [
	^ itemPresenterFactory
]

{ #category : #accessing }
PtyShowListTask >> itemPresenterFactory: anObject [
	itemPresenterFactory := anObject
]
