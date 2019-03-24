Class {
	#name : #PtyConcreteContextClassGroupTests,
	#superclass : #TestCase,
	#instVars : [
		'group'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyConcreteContextClassGroupTests >> setUp [ 
	super setUp.
	
	group := PtyConcreteContextClassGroup new.
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testAddingNewPrototypeWhenChildContextAlreadyExists [ 

	[:prototypeContext :contextPrototypes |
		group contents at: #contextName put: contextPrototypes.
	
		[group add: #prototype to: prototypeContext]
			should strictly satisfy: 
		[prototypeContext name willReturn: #contextName.
		contextPrototypes defaultPrototype: #prototype].
	
	] runWithMocks 
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testAddingNewPrototypeWhenChildContextNotExists [ 

	| contextPrototypes newCollection |
	[:prototypeContext :prototype|
		group contents removeAll.
		group parent: #parentCollection.
	
		[group add: prototype to: prototypeContext]
			should strictly satisfy: 
		[prototypeContext name willReturn: #contextName.
		(prototype collection: (Kind of: PtyPrototypesCollection))
			will: [:arg | newCollection := arg]].
	
		contextPrototypes := group contents at: #contextName.
		contextPrototypes defaultPrototype should be: prototype.
		newCollection parent should be: #parentCollection
	
	] runWithMocks 
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testContainsExistedCollectionAtExistedContext [

	[:prototypeContext :contextPrototypes |
		group contents at: #contextName put: contextPrototypes.
	
		[(group has: contextPrototypes at: prototypeContext) should be: true]
			should strictly satisfy: 
		[prototypeContext name willReturn: #contextName].
	
	] runWithMocks 
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testGettingPrototypesInContextWhenItExists [

	| actual |
	[:prototypeContext |
		group contents at: #contextName put: #result.
	
		[actual := group prototypesFor: #entity inContextOf: prototypeContext]
			should strictly satisfy: 
		[prototypeContext name willReturn: #contextName].
	
		actual should be: #result
	] runWithMocks 
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testGettingPrototypesInContextWhenItNotExists [

	| actual |
	[:prototypeContext |
		group contents removeAll.
	
		[actual := group prototypesFor: #entity inContextOf: prototypeContext]
			should strictly satisfy: 
		[prototypeContext name willReturn: #contextName].
	
		actual should be: nil
	] runWithMocks 
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testHasEmptyContentsByDefault [

	group contents should beKindOf: Dictionary.
	group contents should be isEmpty
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testNotContainsCollectionAtAbsentContext [

	[:prototypeContext :contextPrototypes |
		group contents removeAll.
	
		[(group has: contextPrototypes at: prototypeContext) should be: false]
			should strictly satisfy: 
		[prototypeContext name willReturn: #contextName].
	
	] runWithMocks 
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testNotContainsWrongCollectionAtExistedContext [

	[:prototypeContext :contextPrototypes |
		group contents at: #contextName put: #anotherPrototypes.
	
		[(group has: contextPrototypes at: prototypeContext) should be: false]
			should strictly satisfy: 
		[prototypeContext name willReturn: #contextName].
	
	] runWithMocks 
]

{ #category : #tests }
PtyConcreteContextClassGroupTests >> testRemovingPrototypes [

	group contents at: #contextName1 put: #contextPrototypes1.
	group contents at: #contextName2 put: #contextPrototypes2.
	
	group remove: #contextPrototypes2.
	
	group contents should includeKey: #contextName1.
	group contents should not includeKey: #contextName2.		
	
	
]
