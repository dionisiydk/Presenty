Class {
	#name : #PtyArbitraryContextsGroupTests,
	#superclass : #TestCase,
	#instVars : [
		'group'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyArbitraryContextsGroupTests >> setUp [ 
	super setUp.
	
	group := PtyArbitraryContextsGroup new
]

{ #category : #tests }
PtyArbitraryContextsGroupTests >> testGettingPrototypesInContext [

	| actual |
	[:activeContext :existedContext1 :existedContext2 |
		group contents 
			add: (Association key: existedContext1 value: #prototypes1); 
			add: (Association key: existedContext2 value: #prototypes2).
	
		[actual := group prototypesFor: #entity inContextOf: activeContext]
			should strictly satisfy: 
		[(existedContext1 isActiveFor: #entity) willReturn: false.
		(existedContext2 isActiveFor: #entity) willReturn: true].
	
		actual should be: #prototypes2
	] runWithMocks 
]

{ #category : #tests }
PtyArbitraryContextsGroupTests >> testGettingPrototypesInContextWhenItNotExists [

	| actual |
	[:activeContext :existedContext1 :existedContext2 |
		group contents 
			add: (Association key: existedContext1 value: #prototypes1); 
			add: (Association key: existedContext2 value: #prototypes2).
	
		[actual := group prototypesFor: #entity inContextOf: activeContext]
			should strictly satisfy: 
		[(existedContext1 isActiveFor: #entity) willReturn: false.
		(existedContext2 isActiveFor: #entity) willReturn: false].
	
		actual should be: nil
	] runWithMocks 
]

{ #category : #tests }
PtyArbitraryContextsGroupTests >> testHasEmptyContentsByDefault [ 
	
	group contents should be isEmpty
]

{ #category : #tests }
PtyArbitraryContextsGroupTests >> testRemovingPrototypes [ 

	group contents 
			add: #context1 -> #prototypes1; 
			add: #context2 -> #prototypes2.
	
	group remove: #prototypes2.

	group contents should haveSize: 1.
	group contents first should equal: #context1->#prototypes1
]
