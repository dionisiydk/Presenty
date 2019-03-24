Class {
	#name : #PtyDefaultPrototypeLookupTests,
	#superclass : #TestCase,
	#instVars : [
		'lookup',
		'prototypeFactory'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyDefaultPrototypeLookupTests >> setUp [ 
	super setUp.
	
	prototypeFactory := Mock new.
	lookup := PtyDefaultPrototypeLookup with: prototypeFactory
]

{ #category : #tests }
PtyDefaultPrototypeLookupTests >> testSeachingPrototype [

	| actual |
	[:prototypesCollection |
		[actual := lookup searchPrototypeFor: #object in: prototypesCollection]
			should strictly satisfy: 
		[prototypesCollection defaultPrototype willReturn: #existedPrototype.
		(prototypeFactory canPrototype: #existedPrototype supplyInstancesFor: #object)
			willReturn: true].
	
		actual should be: #existedPrototype
	] runWithMocks 
]

{ #category : #tests }
PtyDefaultPrototypeLookupTests >> testSeachingPrototypeWhenDefaulsBadForGivenObject [

	| actual |
	[:prototypesCollection :prototype |
		lookup prototypeFactory: prototypeFactory.		
		[actual := lookup searchPrototypeFor: #object in: prototypesCollection]
			should strictly satisfy: 
		[prototypesCollection defaultPrototype willReturn: #existedPrototype.
		(prototypeFactory canPrototype: #existedPrototype supplyInstancesFor: #object)
			willReturn: false.
		(prototypeFactory createPrototypeFor: #object) willReturn: prototype.
		prototype collection: prototypesCollection].
	
		actual should be: prototype
	] runWithMocks 
]

{ #category : #tests }
PtyDefaultPrototypeLookupTests >> testSeachingPrototypeWhenDefaultAbsent [

	| actual |
	[:prototypesCollection :prototype |
		lookup prototypeFactory: prototypeFactory.		
		[actual := lookup searchPrototypeFor: #object in: prototypesCollection]
			should strictly satisfy: 
		[prototypesCollection defaultPrototype willReturn: nil.
		(prototypeFactory createPrototypeFor: #object) willReturn: prototype.
		prototype collection: prototypesCollection].
	
		actual should be: prototype
	] runWithMocks 
]
