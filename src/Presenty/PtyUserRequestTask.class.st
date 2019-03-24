Class {
	#name : #PtyUserRequestTask,
	#superclass : #PtyTask,
	#instVars : [
		'action',
		'presenter'
	],
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtyUserRequestTask >> action [
	^ action
]

{ #category : #accessing }
PtyUserRequestTask >> action: anObject [
	action := anObject
]

{ #category : #execution }
PtyUserRequestTask >> body [

	presenter ifNotNil: [guide addViewAreaBody: presenter].
	action ifNotNil: [guide addUIAction: action].
	
	guide performUserRequest
]

{ #category : #accessing }
PtyUserRequestTask >> presenter [
	^ presenter
]

{ #category : #accessing }
PtyUserRequestTask >> presenter: anObject [
	presenter := anObject
]
