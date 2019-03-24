Class {
	#name : #PtyObjectAspectRequest,
	#superclass : #Notification,
	#instVars : [
		'selector'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #'instance creation' }
PtyObjectAspectRequest class >> for: aSymbol [
	^(self new selector: aSymbol) signal
]

{ #category : #accessing }
PtyObjectAspectRequest >> selector [
	^ selector
]

{ #category : #accessing }
PtyObjectAspectRequest >> selector: anObject [
	selector := anObject
]
