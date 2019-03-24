Class {
	#name : #PtyNamedPrototypeContext,
	#superclass : #PtyDomainPrototypeContext,
	#instVars : [
		'name'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyNamedPrototypeContext class >> named: aString [

	^self new 
		name: aString 
]

{ #category : #accessing }
PtyNamedPrototypeContext >> name [
	^name
]

{ #category : #accessing }
PtyNamedPrototypeContext >> name: anObject [
	name := anObject
]

{ #category : #printing }
PtyNamedPrototypeContext >> printOn: aStream [

	super printOn: aStream.
	name ifNotNil: [
		aStream 
			nextPut: $(;
			nextPutAll: name;
			nextPut: $)		
		]
]
