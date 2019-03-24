Class {
	#name : #PtyValueHolder,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #accessing }
PtyValueHolder >> on: anAnnouncement send: aSymbol to: subscriber [
]

{ #category : #accessing }
PtyValueHolder >> unsubscribe: anObject [

]

{ #category : #accessing }
PtyValueHolder >> value [
	^ value
]

{ #category : #accessing }
PtyValueHolder >> value: anObject [
	value := anObject
]
