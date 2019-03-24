Class {
	#name : #PtyAddUserActionTask,
	#superclass : #PtyAddExtraTask,
	#category : #'Presenty-Core'
}

{ #category : #execution }
PtyAddUserActionTask >> body [

	guide addUserAction: targetTask 
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
