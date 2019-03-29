Class {
	#name : #PtyAddUserActionTask,
	#superclass : #PtyAddExtraTask,
	#category : #'Presenty-Core'
}

{ #category : #execution }
PtyAddUserActionTask >> body [

	worker addUserAction: targetTask 
]

{ #category : #accessing }
PtyAddUserActionTask >> defaultActivationStrategy [
	^super defaultActivationStrategy
		shouldRememberTask: false;
		yourself
]

{ #category : #testing }
PtyAddUserActionTask >> shouldRestoreParentArea [
	^false
]
