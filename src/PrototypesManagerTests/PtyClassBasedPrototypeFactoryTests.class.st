Class {
	#name : #PtyClassBasedPrototypeFactoryTests,
	#superclass : #PtyPrototypeFactoryTestCase,
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyClassBasedPrototypeFactoryTests >> factoryClass [ 
	^PtyClassBasedPrototypeFactory 
]

{ #category : #tests }
PtyClassBasedPrototypeFactoryTests >> testCheckingPrototype [

	[:prototype :sample |
		[(factory canPrototype: prototype supplyInstancesFor: #object) should be: #result]
			should strictly satisfy: 			
		[prototype newInstance willReturn: sample.
		sample readSampleProperitiesFrom: #object.
		(sample canBePrototypeInContextOf: #object) willReturn: #result].
				
	] runWithMocks 
]

{ #category : #tests }
PtyClassBasedPrototypeFactoryTests >> testCreationPrototypeWhenNoPreferredInstance [

	| actual |
	[:requestedObject :prototypeClass :sample |
		[actual := factory createPrototypeFor: requestedObject]
			should strictly satisfy: 
		[requestedObject ptyPrototypeClass willReturn: prototypeClass.
		prototypeClass definesPreferredInstance willReturn: false.
		(prototypeClass appropriateInstanceInContextOf: requestedObject) willReturn: sample].
	
		actual should beInstanceOf: PtyPrototype.
		actual sample should be: sample.
		actual prototypeClass should be: prototypeClass
		
	] runWithMocks 
]

{ #category : #tests }
PtyClassBasedPrototypeFactoryTests >> testCreationPrototypeWhenPreferredInstanceDefined [

	| actual |
	[:requestedObject :prototypeClass :sample |
		[actual := factory createPrototypeFor: requestedObject]
			should strictly satisfy: 
		[requestedObject ptyPrototypeClass willReturn: prototypeClass.
		prototypeClass definesPreferredInstance willReturn: true.
		(prototypeClass createPreferredInstanceBy: factory) willReturn: sample].
	
		actual should beInstanceOf: PtyPrototype.
		actual sample should be: sample.
		actual prototypeClass should be: prototypeClass
		
	] runWithMocks 
]
