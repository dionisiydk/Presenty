Class {
	#name : #PtyPrototypesManagerTests,
	#superclass : #TestCase,
	#instVars : [
		'manager',
		'lookupBuilder'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypesManagerTests >> setUp [
	super setUp.
	
	lookupBuilder := Mock new.
	manager := PtyPrototypesManager new.
	manager lookupBuilder: lookupBuilder
	
]

{ #category : #tests }
PtyPrototypesManagerTests >> testGettingContextGroupsForObject [

	[		
		[(manager contextGroupsFor: #object) should be: #result] 
			should lenient satisfy: 
		[(lookupBuilder buildLookupFor: #object) willReturn: #lookup.
		(lookupBuilder convert: #lookup toContextGroupsOf: #object) willReturn: #result].					

	] runWithMocks 

]

{ #category : #tests }
PtyPrototypesManagerTests >> testGettingPrototypeFactory [

	[		
		[manager prototypeFactory should be: #result] 
			should lenient satisfy: 
		[lookupBuilder prototypeFactory willReturn: #result].					

	] runWithMocks 

]

{ #category : #tests }
PtyPrototypesManagerTests >> testGettingPrototypeForObject [

	| actual |
	[:object :lookup|
		manager prototypes at: #contextName put: #prototypes.
		
		[actual := (manager prototypeFor: object)] 
			should lenient satisfy: 
		[object prototypeContextName willReturn: #contextName.
		(lookupBuilder buildLookupFor: object) willReturn: lookup.
		(lookup searchPrototypeFor: object in: #prototypes) willReturn: #result].					

		actual should be: #result
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypesManagerTests >> testGettingPrototypesForObjectWhenItAbsent [

	| actual |
	[:object |
		[actual := (manager prototypesFor: object)] 
			should lenient satisfy: 
		[object prototypeContextName willReturn: #contextName].					
		
		actual should beInstanceOf: PtyPrototypesCollection.
		(manager prototypes at: #contextName) should be: actual
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypesManagerTests >> testGettingPrototypesForObjectWhenItExists [

	| actual |
	[:object |
		manager prototypes at: #contextName put: #prototypes.
		
		[actual := (manager prototypesFor: object)] 
			should lenient satisfy: 
		[object prototypeContextName willReturn: #contextName].					

		actual should be: #prototypes
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypesManagerTests >> testHasEmptyPrototypesByDefault [
	
	manager prototypes size should be: 0
]
