Class {
	#name : #PtyPrototypeTests,
	#superclass : #TestCase,
	#instVars : [
		'prototype',
		'sample',
		'collection'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypeTests >> setUp [ 
	super setUp.
	
	sample := Mock new. 
	collection := Mock new.
	prototype := PtyPrototype new.
	prototype sample: sample.
	prototype collection: collection

]

{ #category : #tests }
PtyPrototypeTests >> testAssignedWhenItsDefaultPrototypeOfCollection [
	
	[
		[ prototype isAssigned should be: true] 
			should lenient satisfy: 
		[ collection defaultPrototype willReturn: prototype].
	
	] runWithMocks
]

{ #category : #tests }
PtyPrototypeTests >> testAssignmentToCollection [
	
	[
		[ prototype assignToCollection ] 
			should lenient satisfy: 
		[ collection defaultPrototype: prototype ].
	
	] runWithMocks
]

{ #category : #tests }
PtyPrototypeTests >> testCreationCopy [
	
	| actual |
	[
		prototype prototypeClass: #prototypeClass.
		[ actual := prototype createCopy] 
			should lenient satisfy: 
		[ sample copyAsPrototype willReturn: #sampleCopy].
	
		actual should beInstanceOf: PtyPrototype.
		actual sample should be: #sampleCopy.
		actual prototypeClass should be: #prototypeClass
	] runWithMocks
]

{ #category : #tests }
PtyPrototypeTests >> testCreationNewInstance [
	
	[
		[ prototype newInstance should be: #instance ] 
			should lenient satisfy: 
		[ sample copyAsNewInstance willReturn: #instance] 
	] runWithMocks
]

{ #category : #tests }
PtyPrototypeTests >> testDeletion [
	
	[
		[ prototype delete ] 
			should lenient satisfy: 
		[collection removeDefaultPrototype. 
		collection delete] 
	] runWithMocks
]

{ #category : #tests }
PtyPrototypeTests >> testGettingSampleClass [
	
	prototype sample: 'test sample as string'.
	
	prototype sampleClass should be: ByteString
]

{ #category : #tests }
PtyPrototypeTests >> testNotAssignedWhenItsNotDefaultPrototypeOfCollection [
	
	[
		[ prototype isAssigned should be: false] 
			should lenient satisfy: 
		[ collection defaultPrototype willReturn: #anotherPrototype].
	
	] runWithMocks
]

{ #category : #tests }
PtyPrototypeTests >> testSavingNewSample [
	
	[:newSample |
		[prototype saveNewSample: newSample]
			should lenient satisfy: 
		[newSample copyAsPrototype willReturn: #newPrototypeSample.
		collection defaultPrototype: prototype].
	
		prototype sample should be: #newPrototypeSample
	
	] runWithMocks 
]

{ #category : #tests }
PtyPrototypeTests >> testSettingNewSampleFromClass [
	
	[:class :newSample |
		prototype sample: #currentSample.
		
		[ prototype useSampleOf: class] 
			should lenient satisfy: 
		[ class new willReturn: newSample].
		
		prototype sample should be: newSample.			
	] runWithMocks
]
