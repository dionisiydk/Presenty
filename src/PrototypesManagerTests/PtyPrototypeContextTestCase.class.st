Class {
	#name : #PtyPrototypeContextTestCase,
	#superclass : #TestCase,
	#instVars : [
		'context'
	],
	#category : #PrototypesManagerTests
}

{ #category : #testing }
PtyPrototypeContextTestCase class >> isAbstract [ 
	^self == PtyPrototypeContextTestCase
]

{ #category : #running }
PtyPrototypeContextTestCase >> contextClass [
	self subclassResponsibility 
]

{ #category : #running }
PtyPrototypeContextTestCase >> setUp [ 
	super setUp.
	
	context := self contextClass new
]

{ #category : #tests }
PtyPrototypeContextTestCase >> testGettingContextClass [

	context contextClass should be: self contextClass 
	
]
