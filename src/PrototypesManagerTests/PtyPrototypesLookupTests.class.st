Class {
	#name : #PtyPrototypesLookupTests,
	#superclass : #TestCase,
	#instVars : [
		'lookup',
		'nextLookup',
		'prototypeContext'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypesLookupTests >> setUp [ 
	super setUp.
	
	nextLookup := Mock new.
	prototypeContext := Mock new.
	lookup := PtyPrototypesLookup new.
	lookup 
		context: prototypeContext;
		nextContextLookup: nextLookup
]

{ #category : #tests }
PtyPrototypesLookupTests >> testCheckingExistenceContextLikeAnotherContext [

	[:anotherContext |
		[(lookup hasContextLike: anotherContext) should be: #result]
			should strictly satisfy: 
		[anotherContext contextClass willReturn: #contextClass.
		(prototypeContext isKindOf: #contextClass) willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesLookupTests >> testCreationFullLookupChain [

	[:parentContext :parentLookup :domainContextsLookup |
		[(lookup createFullLookupChainBy: #contextsProvider) should be: #result]
			should strictly satisfy: 
		[(prototypeContext createDomainContextsLookupBy: #contextsProvider with: nextLookup) 
				willReturn: domainContextsLookup.
		domainContextsLookup parentContextLookup: lookup.
		prototypeContext parent willReturn: parentContext.
		(parentContext createLookupWith: lookup) willReturn: parentLookup.
		(parentLookup createFullLookupChainBy: #contextsProvider) willReturn: #result].
	
		lookup nextContextLookup should be: domainContextsLookup
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesLookupTests >> testCreationFullLookupChainWhenParentContextAbsent [

	[:domainContextsLookup |
		[(lookup createFullLookupChainBy: #contextsProvider) should be: lookup]
			should strictly satisfy: 
		[(prototypeContext createDomainContextsLookupBy: #contextsProvider with: nextLookup) 
				willReturn: domainContextsLookup.
		domainContextsLookup parentContextLookup: lookup.
		prototypeContext parent willReturn: nil].
	
		lookup nextContextLookup should be: domainContextsLookup
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesLookupTests >> testDetectionDomainContexts [

	[:domainContextsLookup |
		[lookup detectDomainContextsBy: #contextsProvider ]
			should strictly satisfy: 
		[(prototypeContext createDomainContextsLookupBy: #contextsProvider with: nextLookup) 
				willReturn: domainContextsLookup.
		domainContextsLookup parentContextLookup: lookup].
	
		lookup nextContextLookup should be: domainContextsLookup
	
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesLookupTests >> testSearchingPrototype [ 

	| actual |
	[:prototypes | 
		[actual := lookup searchPrototypeFor: #entity in: prototypes]
			should strictly satisfy: 
		[(prototypes prototypesFor: #entity inContextOf: prototypeContext) willReturn: #specificPrototypes.
		(nextLookup searchPrototypeFor: #entity in: #specificPrototypes) willReturn: #result].
	
		actual should be: #result
	] runWithMocks 
]
