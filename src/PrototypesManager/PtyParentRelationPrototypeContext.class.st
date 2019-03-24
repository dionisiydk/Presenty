Class {
	#name : #PtyParentRelationPrototypeContext,
	#superclass : #PtyBasePrototypeContext,
	#category : #PrototypesManager
}

{ #category : #accessing }
PtyParentRelationPrototypeContext >> name [ 

	^subject prototypeContextName
]

{ #category : #accessing }
PtyParentRelationPrototypeContext >> parent [
	| parentSubject |
	parentSubject := self subjectParent.
	
	parentSubject ifNil: [^nil].
	
	^self class of: parentSubject
]

{ #category : #accessing }
PtyParentRelationPrototypeContext >> subjectParent [
	^subject parent
]
