Class {
	#name : #PtyPrototypeLookupBuildingTests,
	#superclass : #TestCase,
	#instVars : [
		'prototypeFactory',
		'lookupBuilder',
		'object',
		'defaultLookup',
		'baseContexts',
		'contextsProvider'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypeLookupBuildingTests >> setUp [
	super setUp.
	
	object := Mock new.
	defaultLookup := Mock new.
	contextsProvider := Mock new.
	prototypeFactory := Mock new.
	lookupBuilder := PtyPrototypeLookupBuilder with: prototypeFactory.
	lookupBuilder 
		contextsProvider: contextsProvider.
	baseContexts := OrderedCollection new
]

{ #category : #running }
PtyPrototypeLookupBuildingTests >> setUpStubs [
	prototypeFactory defaultPrototypeLookup willReturn: defaultLookup; useArbitrarily.
	object basePrototypeContexts willReturn: baseContexts; useArbitrarily.		
]

{ #category : #tests }
PtyPrototypeLookupBuildingTests >> testWhenNoBasePrototypeContexts [

	| actual |
	[:lookup |
		baseContexts removeAll.
		[actual := lookupBuilder buildLookupFor: object]
			should strictly satisfy: 
		[self setUpStubs].
	
		actual should be: defaultLookup
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypeLookupBuildingTests >> testWhenSingleBasePrototypeContext [

	| actual |
	[:lookup :context1 |
		baseContexts add: context1.
		[actual := lookupBuilder buildLookupFor: object]
			should strictly satisfy: 
		[self setUpStubs.
		(context1 createLookupWith: defaultLookup) willReturn: lookup.
		(lookup createFullLookupChainBy: contextsProvider) willReturn: #resultLookup].
	
		actual should be: #resultLookup
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypeLookupBuildingTests >> testWhenTwoBasePrototypeContexts [

	| actual |
	[:lookup1 :lookup2 :context1 :context2 |
		baseContexts add: context1; add: context2.
		[actual := lookupBuilder buildLookupFor: object]
			should strictly satisfy: 
		[self setUpStubs.
		(context1 createLookupWith: defaultLookup) willReturn: lookup1.
		(lookup1 createFullLookupChainBy: contextsProvider) willReturn: #resultLookup1.
		
		(context2 createLookupWith: #resultLookup1) willReturn: lookup2.
		(lookup2 createFullLookupChainBy: contextsProvider) willReturn: #resultLookup2].
	
		actual should be: #resultLookup2
	] runWithMocks 
]
