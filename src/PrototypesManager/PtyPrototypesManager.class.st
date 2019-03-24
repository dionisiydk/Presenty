Class {
	#name : #PtyPrototypesManager,
	#superclass : #Object,
	#instVars : [
		'prototypes',
		'lookupBuilder'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyPrototypesManager class >> with: aPrototypeFactory [

	^self new 
		lookupBuilder: (PtyPrototypeLookupBuilder with: aPrototypeFactory) 
]

{ #category : #accessing }
PtyPrototypesManager >> contextGroupsFor: anObject [

	| lookup |
	lookup := lookupBuilder buildLookupFor: anObject.
	^lookupBuilder convert: lookup toContextGroupsOf: anObject
]

{ #category : #'initialize-release' }
PtyPrototypesManager >> initialize [ 
	super initialize.
	prototypes := Dictionary new
]

{ #category : #accessing }
PtyPrototypesManager >> lookupBuilder [
	^ lookupBuilder
]

{ #category : #accessing }
PtyPrototypesManager >> lookupBuilder: anObject [
	lookupBuilder := anObject
]

{ #category : #accessing }
PtyPrototypesManager >> prototypeFactory [
	^ lookupBuilder prototypeFactory
]

{ #category : #accessing }
PtyPrototypesManager >> prototypeFor: anObject [
	
	| objectPrototypes lookup |
	objectPrototypes := self prototypesFor: anObject.
	
	lookup := lookupBuilder buildLookupFor: anObject.
	
	^lookup searchPrototypeFor: anObject in: objectPrototypes
]

{ #category : #accessing }
PtyPrototypesManager >> prototypes [
	^ prototypes
]

{ #category : #accessing }
PtyPrototypesManager >> prototypes: anObject [
	prototypes := anObject
]

{ #category : #accessing }
PtyPrototypesManager >> prototypesFor: anObject [

	^prototypes at: anObject prototypeContextName 	ifAbsentPut: [PtyPrototypesCollection new]
]
