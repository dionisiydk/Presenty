Class {
	#name : #PtyPrototypeFactoryTestCase,
	#superclass : #TestCase,
	#instVars : [
		'factory'
	],
	#category : #PrototypesManagerTests
}

{ #category : #testing }
PtyPrototypeFactoryTestCase class >> isAbstract [ 
	^self == PtyPrototypeFactoryTestCase
]

{ #category : #running }
PtyPrototypeFactoryTestCase >> setUp [ 
	super setUp.
	
	factory := self factoryClass new
]
