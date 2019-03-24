Class {
	#name : #PtyNullTaskContext,
	#superclass : #Object,
	#category : #'Presenty-Core'
}

{ #category : #activation }
PtyNullTaskContext >> activateNewTask: aPtyPluggableTask by: aPtyGuide [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
PtyNullTaskContext >> activation [ 
	^nil
]

{ #category : #activation }
PtyNullTaskContext >> createNewContextFor: aPtyTask [ 

	| newContext |
	newContext := PtyTaskContext of: aPtyTask.
	newContext activationPoint: (PtyTaskActivationPoint createdFrom: self).
	^newContext
]

{ #category : #testing }
PtyNullTaskContext >> isCreatedInContextOf: aTask [ 
	^false
]

{ #category : #testing }
PtyNullTaskContext >> shouldRestoreParentArea [
	^true
]

{ #category : #accessing }
PtyNullTaskContext >> task [
	^PtyNullTask new
]
