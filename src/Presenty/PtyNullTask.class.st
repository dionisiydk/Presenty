Class {
	#name : #PtyNullTask,
	#superclass : #Object,
	#category : #'Presenty-Core'
}

{ #category : #testing }
PtyNullTask >> hasPrototype [
	^false
]

{ #category : #testing }
PtyNullTask >> isCreatedByCurrentRequest [
	^false
]

{ #category : #accessing }
PtyNullTask >> parent [
	^nil
]

{ #category : #accessing }
PtyNullTask >> parentTask [
	^nil
]

{ #category : #accessing }
PtyNullTask >> prototypeContextName [
	^self class name
]
