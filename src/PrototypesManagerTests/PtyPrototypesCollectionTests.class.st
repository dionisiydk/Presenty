Class {
	#name : #PtyPrototypesCollectionTests,
	#superclass : #TestCase,
	#instVars : [
		'prototypes'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypesCollectionTests >> setUp [
	super setUp.
	
	prototypes := PtyPrototypesCollection new
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testAddingNewPrototypeWhenChildContextAlreadyExists [

	| actual |
	[:prototypeContext :contextGroup :prototype |
		prototypes childContexts at: #contextClass put: contextGroup.
		
		[actual := prototypes add: prototype to: prototypeContext]
			should strictly satisfy: 
		[prototypeContext contextClass willReturn: #contextClass.
		prototype createCopy willReturn: #prototypeCopy.
		contextGroup add: #prototypeCopy to: prototypeContext].
			
		actual should be: #prototypeCopy
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testAddingNewPrototypeWhenChildContextNotExists [

	| newGroup actual |
	[:prototypeContext :contextGroup :prototype |
		prototypes childContexts removeAll.
		
		[actual := prototypes add: prototype to: prototypeContext]
			should strictly satisfy: 
		[prototypeContext contextClass willReturn: #contextClass.
		prototypeContext createContextGroup willReturn: contextGroup.
		contextGroup parent: prototypes.
		prototype createCopy willReturn: #prototypeCopy.
		contextGroup add: #prototypeCopy to: prototypeContext].
	
		prototypes childContexts should includeKey: #contextClass.
		newGroup := (prototypes childContexts at: #contextClass).
		newGroup should be: contextGroup.
		actual should be: #prototypeCopy
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testBelongsToContextWhenParentContainsIt [

	[:prototypeContext :parentCollection |
		prototypes parent: parentCollection.
				
		[(prototypes belongsTo: prototypeContext) should be: true]
			should strictly satisfy: 
		[(parentCollection has: prototypes at: prototypeContext) willReturn: true].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testBelongsToContextWhenParentNotContainsIt [

	[:prototypeContext :parentCollection |
		prototypes parent: parentCollection.
				
		[(prototypes belongsTo: prototypeContext) should be: #result]
			should strictly satisfy: 
		[(parentCollection has: prototypes at: prototypeContext) willReturn: false.
		(parentCollection belongsTo: prototypeContext) willReturn: #result].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testContainsChildAtExistedContextsGroup [

	[:prototypeContext :childCollection :contextGroup |
		prototypes childContexts at: #contextClass put: contextGroup.
				
		[(prototypes has: childCollection at: prototypeContext) should be: #result]
			should strictly satisfy: 
		[prototypeContext contextClass willReturn: #contextClass.
		(contextGroup has: childCollection at: prototypeContext) willReturn: #result].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testDeletion [

	[:prototypeContext :parentCollection |
		prototypes parent: parentCollection.
				
		[prototypes delete]
			should strictly satisfy: 
		[(parentCollection removeChild: prototypes) willReturn: true].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testDeletionWhenChildContextsNotEmpty [

	prototypes childContexts at: #someContext put: #contextGroup.
				
	[prototypes delete] should raise: Warning
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testDeletionWhenNoParent [

	prototypes parent: nil.
				
	prototypes delete
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingParentWhichBelongsToContext [

	[:prototypeContext :parentCollection |
		prototypes parent: parentCollection.
				
		[(prototypes findParentWhichBelongsTo: prototypeContext) should be: parentCollection]
			should strictly satisfy: 
		[(parentCollection belongsTo: prototypeContext) willReturn: true].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingParentWhichBelongsToContextWhenItsNotParent [

	[:prototypeContext :parentCollection |
		prototypes parent: parentCollection.
				
		[(prototypes findParentWhichBelongsTo: prototypeContext) should be: #result]
			should strictly satisfy: 
		[(parentCollection belongsTo: prototypeContext) willReturn: false.
		(parentCollection findParentWhichBelongsTo: prototypeContext) willReturn: #result].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingParentWhichBelongsToContextWhenParentAbsent [

	prototypes parent: nil.
				
	(prototypes findParentWhichBelongsTo: #prototypeContext) should be: nil
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingPrototypesInContext [

	| actual |
	[:prototypeContext :contextGroup |
		prototypes childContexts at: #contextClass put: contextGroup.
		
		[actual := prototypes prototypesFor: #entity inContextOf: prototypeContext]
			should strictly satisfy: 
		[prototypeContext contextClass willReturn: #contextClass.
		(contextGroup prototypesFor: #entity inContextOf: prototypeContext) willReturn: #result].
			
		actual should be: #result
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingPrototypesInContextWhenChildContextsEmpty [

	| actual |
	prototypes childContexts removeAll.
		
	actual := prototypes prototypesFor: #entity inContextOf: #prototypeContext.
	
	actual should be: prototypes
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingPrototypesInContextWhenItNotExist [

	| actual |
	[:prototypeContext :contextGroup |
		prototypes childContexts at: #contextClass put: contextGroup.
		
		[actual := prototypes prototypesFor: #entity inContextOf: prototypeContext]
			should strictly satisfy: 
		[prototypeContext contextClass willReturn: #contextClass.
		(contextGroup prototypesFor: #entity inContextOf: prototypeContext) willReturn: nil].
			
		actual should be: prototypes
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingPrototypesInContextWhenNoGroupForContextClass [

	| actual |
	[:prototypeContext :contextGroup |
		prototypes childContexts at: #contextClass put: contextGroup.
		
		[actual := prototypes prototypesFor: #entity inContextOf: prototypeContext]
			should strictly satisfy: 
		[prototypeContext contextClass willReturn: #anotherContextClass].
			
		actual should be: prototypes
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingRootWhenParentAbsent [

	prototypes parent: nil.
				
	prototypes root should be: prototypes
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testGettingRootWhenParentExists [

	[:prototypeContext :parentCollection |
		prototypes parent: parentCollection.
				
		[prototypes root should be: #result]
			should strictly satisfy: 
		[parentCollection root willReturn: #result].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testHasEmptyChildContextsDictionaryByDefault [

	prototypes childContexts should beKindOf: Dictionary.
	prototypes childContexts should be isEmpty 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testIncludedToParentAtContextWhenParentExists [

	[:prototypeContext :parentCollection |
		prototypes parent: parentCollection.
				
		[(prototypes includedToParentAt: prototypeContext) should be: #result]
			should strictly satisfy: 
		[(parentCollection has: prototypes at: prototypeContext) willReturn: #result].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testNotBelongsToContextWhenNoParent [

	prototypes parent: nil.
	
	(prototypes belongsTo: #prototypeContext) should be: false
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testNotContainsChildAtAbsentContextsGroup [

	[:prototypeContext :childCollection |
		prototypes childContexts removeAll.
				
		[(prototypes has: childCollection at: prototypeContext) should be: false]
			should strictly satisfy: 
		[prototypeContext contextClass willReturn: #contextClass].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testNotIncludedToParentAtContextWhenNoParent [

	prototypes parent: nil.
	
	(prototypes includedToParentAt: #prototypeContext) should be: false
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testRemovingChild [

	[:contextGroup1 :contextGroup2 |
		prototypes childContexts at: #contextClass1 put: contextGroup1.
		prototypes childContexts at: #contextClass2 put: contextGroup2.
		
		[prototypes removeChild: #childPrototypes]
			should lenient satisfy: 
		[contextGroup1 remove: #childPrototypes.
		contextGroup2 remove: #childPrototypes].
			
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypesCollectionTests >> testRemovingDefaultPrototype [

	prototypes defaultPrototype: PtyPrototype new.
	
	prototypes removeDefaultPrototype.
	
	prototypes defaultPrototype should be: nil
]
