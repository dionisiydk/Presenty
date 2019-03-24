Class {
	#name : #PtyPrototypeClass,
	#superclass : #Object,
	#instVars : [
		'name',
		'actualClass'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyPrototypeClass class >> on: aClass [ 
	^self new 
		actualClass: aClass 
]

{ #category : #accessing }
PtyPrototypeClass >> actualClass [
	^ actualClass
]

{ #category : #accessing }
PtyPrototypeClass >> actualClass: anObject [
	actualClass := anObject
]

{ #category : #accessing }
PtyPrototypeClass >> appropriateInstanceInContextOf: anObject [
	| targetClass sample |
	targetClass := actualClass allSubclasses reverse 
		detect: [:each | sample := each new.
			sample readSampleProperitiesFrom: anObject.
			sample canBePrototypeInContextOf: anObject]
		ifNone: [nil].
		
	targetClass ifNotNil: [^targetClass new].

	sample := actualClass new.
	sample readSampleProperitiesFrom: anObject.
	(sample canBePrototypeInContextOf: anObject)
		ifTrue: [^actualClass new].
		
	PtyNoAppropriatePrototypeError signal
]

{ #category : #accessing }
PtyPrototypeClass >> createPreferredInstanceBy: aPrototypeFactory [
	^actualClass createPreferredInstanceBy: aPrototypeFactory 
]

{ #category : #testing }
PtyPrototypeClass >> definesPreferredInstance [
	^actualClass respondsTo: #createPreferredInstanceBy: 
]

{ #category : #accessing }
PtyPrototypeClass >> name [
	^name ifNil: [actualClass name]
]

{ #category : #accessing }
PtyPrototypeClass >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PtyPrototypeClass >> possiblePrototypeClasses [ 

	^actualClass allSubclasses copyWithFirst: actualClass 
]

{ #category : #printing }
PtyPrototypeClass >> printOn: aStream [

	super printOn: aStream.
	aStream nextPut: $(.
	aStream nextPutAll: self name.
	aStream nextPut: $).
]
