Class {
	#name : #PtyPrototypeFactoryTests,
	#superclass : #TestCase,
	#instVars : [
		'factory'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypeFactoryTests >> setUp [ 
	super setUp.
	
	factory := PtyPrototypeFactory new.
]

{ #category : #tests }
PtyPrototypeFactoryTests >> testCreationDefaultPrototypeLookup [

	| actual |
	actual := factory defaultPrototypeLookup.
	
	actual should beInstanceOf: PtyDefaultPrototypeLookup.
	actual prototypeFactory should be: factory
	
]
