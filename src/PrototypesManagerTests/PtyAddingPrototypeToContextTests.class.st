Class {
	#name : #PtyAddingPrototypeToContextTests,
	#superclass : #TestCase,
	#instVars : [
		'prototype',
		'prototypeCollection',
		'sample',
		'lookupWithTargetContext',
		'targetContext',
		'rootCollection',
		'addedPrototype'
	],
	#category : #PrototypesManagerTests
}

{ #category : #helpers }
PtyAddingPrototypeToContextTests >> addPrototypeToContext [ 

	addedPrototype := prototype addToContextOf: lookupWithTargetContext
]

{ #category : #running }
PtyAddingPrototypeToContextTests >> setUp [ 
	super setUp.
	
	prototypeCollection := Mock new.
	sample := Mock new.
	prototype := PtyPrototype sample: sample.
	prototype collection: prototypeCollection.
	rootCollection := Mock new.
	lookupWithTargetContext := Mock new.
	targetContext := Mock new.
]

{ #category : #running }
PtyAddingPrototypeToContextTests >> setUpStubs [ 

	lookupWithTargetContext context willReturn: targetContext; useArbitrarily.
	prototypeCollection root willReturn: rootCollection; useArbitrarily 
]

{ #category : #tests }
PtyAddingPrototypeToContextTests >> testWhenContextAndItParentsNotContainsPrototypeCollection [

	[
		[self addPrototypeToContext]
			should strictly satisfy: 
		[self setUpStubs.
		(prototypeCollection includedToParentAt: targetContext) willReturn: false.
		(prototypeCollection findParentWhichBelongsTo: targetContext) willReturn: nil.
		lookupWithTargetContext parentContextLookup willReturn: nil.
		
		(rootCollection add: prototype to: targetContext) willReturn: #addedPrototype].
	
		addedPrototype should be: #addedPrototype 
	] runWithMocks 
]

{ #category : #tests }
PtyAddingPrototypeToContextTests >> testWhenContextContainsParentCollection [

	[:parentCollection |
		[self addPrototypeToContext]
			should strictly satisfy: 
		[self setUpStubs.
		(prototypeCollection includedToParentAt: targetContext) willReturn: false.
		(prototypeCollection findParentWhichBelongsTo: targetContext) willReturn: parentCollection.
		lookupWithTargetContext parentContextLookup willReturn: nil.
		
		(parentCollection add: prototype to: targetContext) willReturn: #addedPrototype].
	
		addedPrototype should be: #addedPrototype 
	] runWithMocks 
]

{ #category : #tests }
PtyAddingPrototypeToContextTests >> testWhenContextContainsPrototypeCollection [

	[
		[self addPrototypeToContext]
			should strictly satisfy: 
		[self setUpStubs.
		(prototypeCollection includedToParentAt: targetContext) willReturn: true.
		lookupWithTargetContext parentContextLookup willReturn: nil.
		
		(prototypeCollection add: prototype to: targetContext) willReturn: #addedPrototype].
	
		addedPrototype should be: #addedPrototype 
	] runWithMocks 
]

{ #category : #tests }
PtyAddingPrototypeToContextTests >> testWhenParentContextContainsParentCollection [

	[:parentLookup :parentContext :parentCollection |
		[self addPrototypeToContext]
			should strictly satisfy: 
		[self setUpStubs.
		(prototypeCollection includedToParentAt: targetContext) willReturn: false.
		(prototypeCollection findParentWhichBelongsTo: targetContext) willReturn: nil.
		lookupWithTargetContext parentContextLookup willReturn: parentLookup.
		parentLookup context willReturn: parentContext; useArbitrarily.
		(prototypeCollection includedToParentAt: parentContext) willReturn: false.
		(prototypeCollection findParentWhichBelongsTo: parentContext) willReturn: parentCollection.
		parentLookup parentContextLookup willReturn: nil.
		
		(parentCollection add: prototype to: targetContext) willReturn: #addedPrototype].
	
		addedPrototype should be: #addedPrototype 
	] runWithMocks 
]

{ #category : #tests }
PtyAddingPrototypeToContextTests >> testWhenParentContextContainsPrototypeCollection [

	[:parentLookup :parentContext |
		[self addPrototypeToContext]
			should strictly satisfy: 
		[self setUpStubs.
		(prototypeCollection includedToParentAt: targetContext) willReturn: false.
		(prototypeCollection findParentWhichBelongsTo: targetContext) willReturn: nil.
		lookupWithTargetContext parentContextLookup willReturn: parentLookup.
		parentLookup context willReturn: parentContext; useArbitrarily.
		(prototypeCollection includedToParentAt: parentContext) willReturn: true.
		parentLookup parentContextLookup willReturn: nil.
		
		(prototypeCollection add: prototype to: targetContext) willReturn: #addedPrototype].
	
		addedPrototype should be: #addedPrototype 
	] runWithMocks 
]
