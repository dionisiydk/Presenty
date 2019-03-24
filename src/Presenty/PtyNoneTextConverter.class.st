Class {
	#name : #PtyNoneTextConverter,
	#superclass : #PtyTextConverter,
	#category : #'Presenty-Editor-Fields'
}

{ #category : #testing }
PtyNoneTextConverter >> canConvertString: aString [
	^true
]

{ #category : #'text converting' }
PtyNoneTextConverter >> readValueFrom: aString [ 
	^aString 
]
