Class {
	#name : #PtyExecuteExtraTask,
	#superclass : #PtyAddExtraTask,
	#category : #'Presenty-Core'
}

{ #category : #execution }
PtyExecuteExtraTask >> body [

	^workplace requestUserFor: targetTask 
]
