Class {
	#name : #PtyAddExtraTask,
	#superclass : #PtyTask,
	#instVars : [
		'targetTask'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyAddExtraTask class >> createPreferredInstanceBy: aTaskPrototypeFactory [

	^PtyAddUserActionTask new
	
]

{ #category : #'instance creation' }
PtyAddExtraTask class >> on: aTask [

	^self new 
		targetTask: aTask 
]

{ #category : #accessing }
PtyAddExtraTask >> basePrototypeContexts [
	^{PtyTaskPrototypeContext of: targetTask}, super basePrototypeContexts 
]

{ #category : #printing }
PtyAddExtraTask >> printDetailsOn: aStream [

	aStream nextPut: $(.
	
	name ifNotNil: [aStream nextPutAll: 	name; nextPutAll: ', '].
	
	aStream nextPutAll: targetTask printString.
	
	aStream nextPut: $)
	
]

{ #category : #accessing }
PtyAddExtraTask >> targetTask [
	^ targetTask
]

{ #category : #accessing }
PtyAddExtraTask >> targetTask: anObject [
	targetTask := anObject
]
