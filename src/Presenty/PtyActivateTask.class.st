Class {
	#name : #PtyActivateTask,
	#superclass : #PtyUserAction,
	#instVars : [
		'task'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyActivateTask class >> task: aTask [ 
	^self new 
		task: aTask 
]

{ #category : #accessing }
PtyActivateTask >> defaultPrototypeContextName [
	^task prototypeContextName 
]

{ #category : #execution }
PtyActivateTask >> execute [
	
	presenter guide setUpContext: presenter context.
	
	presenter guide executeTask: task
]

{ #category : #'morphic menu' }
PtyActivateTask >> populatePrototypeConsumerMenu: aMenu [

	aMenu add: 'explore' translated 
		target: self selector: #explore argumentList: #().
	
	aMenu add: 'browse task' translated 
		target: task selector: #browse argumentList: #().
]

{ #category : #accessing }
PtyActivateTask >> task [
	^ task
]

{ #category : #accessing }
PtyActivateTask >> task: anObject [
	task := anObject
]
