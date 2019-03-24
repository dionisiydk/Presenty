Class {
	#name : #PtyFlowBounds,
	#superclass : #Object,
	#instVars : [
		'bounds'
	],
	#category : #'Presenty-UI'
}

{ #category : #'instance creation' }
PtyFlowBounds class >> bounds: aRect [

	^self new bounds: aRect 
]

{ #category : #accessing }
PtyFlowBounds >> bounds [
	^ bounds
]

{ #category : #accessing }
PtyFlowBounds >> bounds: anObject [
	bounds := anObject
]
