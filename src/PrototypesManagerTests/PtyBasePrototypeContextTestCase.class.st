Class {
	#name : #PtyBasePrototypeContextTestCase,
	#superclass : #PtyPrototypeContextTestCase,
	#instVars : [
		'subject'
	],
	#category : #PrototypesManagerTests
}

{ #category : #testing }
PtyBasePrototypeContextTestCase class >> isAbstract [ 
	^self == PtyBasePrototypeContextTestCase 
]

{ #category : #running }
PtyBasePrototypeContextTestCase >> setUp [ 
	super setUp.
	
	subject := Mock new.
	context subject: subject
]

{ #category : #tests }
PtyBasePrototypeContextTestCase >> testCreationDomainContextsLookup [

	| actual |
	[:contextsProvider :context1 :context2 |
		[actual := context createDomainContextsLookupBy: contextsProvider with: #nextLookup]
			should strictly satisfy: 
		[(contextsProvider searchContextsOf: subject) willReturn: {context1. context2}.
		(context1 createLookupWith: #nextLookup) willReturn: #lookup1.
		(context2 createLookupWith: #lookup1) willReturn: #resultLookup].
	
		actual should be: #resultLookup		
	] runWithMocks 
]

{ #category : #tests }
PtyBasePrototypeContextTestCase >> testCreationDomainContextsLookupWhenItAbsent [

	| actual |
	[:contextsProvider |
		[actual := context createDomainContextsLookupBy: contextsProvider with: #nextLookup]
			should strictly satisfy: 
		[(contextsProvider searchContextsOf: subject) willReturn: #()].
	
		actual should be: #nextLookup
	] runWithMocks 
]

{ #category : #tests }
PtyBasePrototypeContextTestCase >> testCreationOnSubject [

	| actual |
	actual := self contextClass of: subject.

	actual should beInstanceOf: self contextClass.
	actual subject should be: subject
]
