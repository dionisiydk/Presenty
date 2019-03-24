Class {
	#name : #PtyInputFocused,
	#superclass : #Announcement,
	#instVars : [
		'input'
	],
	#category : #'Presenty-UI'
}

{ #category : #'instance creation' }
PtyInputFocused class >> input: aTextInputMorph [

	^self new input: aTextInputMorph 
]

{ #category : #accessing }
PtyInputFocused >> input [
	^ input
]

{ #category : #accessing }
PtyInputFocused >> input: anObject [
	input := anObject
]
