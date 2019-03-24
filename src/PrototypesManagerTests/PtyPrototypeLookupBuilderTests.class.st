Class {
	#name : #PtyPrototypeLookupBuilderTests,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypeLookupBuilderTests >> setUp [
	super setUp.
	
	builder := PtyPrototypeLookupBuilder new
]

{ #category : #tests }
PtyPrototypeLookupBuilderTests >> testConvertingLookupToGroups [

	| actual |
	[:lookup :object :nextLookup :nextLookup2 |
		[actual := builder convert: lookup toContextGroupsOf: object]
			should strictly satisfy: 
		[object basePrototypeContexts willReturn: #(context1 context2 context3).
		(lookup isKindOf: PtyDefaultPrototypeLookup) willReturn: false.
		(lookup hasContextLike: #context3) willReturn: true.
		lookup nextContextLookup willReturn: nextLookup.
		(nextLookup isKindOf: PtyDefaultPrototypeLookup) willReturn: false.
		 (nextLookup hasContextLike: #context2) willReturn: true.
		nextLookup nextContextLookup willReturn: nextLookup2.
		(nextLookup2 isKindOf: PtyDefaultPrototypeLookup) willReturn: true].
	
		actual should equal: {
			#context3 -> {lookup} asOrderedCollection.
			#context2 -> {nextLookup} asOrderedCollection
			}.
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypeLookupBuilderTests >> testConvertingLookupToGroupsWhenItBelongsToOnlyOne [

	| actual |
	[:lookup :object :nextLookup :nextLookup2 |
		[actual := builder convert: lookup toContextGroupsOf: object]
			should strictly satisfy: 
		[object basePrototypeContexts willReturn: #(context1 context2 context3).
		(lookup isKindOf: PtyDefaultPrototypeLookup) willReturn: false.
		(lookup hasContextLike: #context3) willReturn: true.
		lookup nextContextLookup willReturn: nextLookup.
		(nextLookup isKindOf: PtyDefaultPrototypeLookup) willReturn: false.
		 (nextLookup hasContextLike: #context2) willReturn: false.
		nextLookup nextContextLookup willReturn: nextLookup2.
		(nextLookup2 isKindOf: PtyDefaultPrototypeLookup) willReturn: true].
	
		actual should equal: {#context3 -> {lookup. nextLookup} asOrderedCollection} 
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypeLookupBuilderTests >> testConvertingLookupToGroupsWhenItsDefault [

	| actual |
	[:lookup :object |
		[actual := builder convert: lookup toContextGroupsOf: object]
			should strictly satisfy: 
		[object basePrototypeContexts willReturn: #(context1 context2).
		(lookup isKindOf: PtyDefaultPrototypeLookup) willReturn: true].
	
		actual should be isEmpty
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypeLookupBuilderTests >> testHasContextProviderByDefault [
	
	builder contextsProvider should beInstanceOf: PtyDomainContextsProvider 
]
