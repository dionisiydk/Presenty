Class {
	#name : #PtyExecuteExtraTask,
	#superclass : #PtyAddExtraTask,
	#category : #'Presenty-Core'
}

{ #category : #execution }
PtyExecuteExtraTask >> body [

	^worker requestUserFor: targetTask 
]
