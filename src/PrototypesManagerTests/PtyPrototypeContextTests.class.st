Class {
	#name : #PtyPrototypeContextTests,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypeContextTests >> setUp [ 
	super setUp.
	
	context := PtyPrototypeContext new.
	
]

{ #category : #tests }
PtyPrototypeContextTests >> testCreationContextGroup [

	| actual |
	actual := context createContextGroup.
	
	actual should beInstanceOf: PtyConcreteContextClassGroup
]

{ #category : #tests }
PtyPrototypeContextTests >> testCreationLookup [

	| actual nextLookup |
	nextLookup := PtyPrototypesLookup new.
	actual := context createLookupWith: nextLookup.
	
	actual should beInstanceOf: PtyPrototypesLookup.
	actual context should be: context.
	actual nextContextLookup should be: nextLookup.
	nextLookup parentContextLookup should be: actual
]
