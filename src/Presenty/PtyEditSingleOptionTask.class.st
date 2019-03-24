Class {
	#name : #PtyEditSingleOptionTask,
	#superclass : #PtyEditRequisiteNewTask,
	#category : #'Presenty-Editor-Tasks'
}

{ #category : #accessing }
PtyEditSingleOptionTask class >> createPreferredInstanceBy: aTaskPrototypeFactory [

	^aTaskPrototypeFactory preferredEditSingleOptionTask
]
