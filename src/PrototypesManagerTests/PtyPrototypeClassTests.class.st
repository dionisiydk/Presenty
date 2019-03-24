Class {
	#name : #PtyPrototypeClassTests,
	#superclass : #TestCase,
	#instVars : [
		'class',
		'actualClass'
	],
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyPrototypeClassTests >> setUp [
	super setUp.
	
	actualClass := Mock new.
	class := PtyPrototypeClass on: actualClass
]

{ #category : #tests }
PtyPrototypeClassTests >> testCheckingPreferredInstance [

	[
		[class definesPreferredInstance should be: #result]
			should strictly satisfy: 
		[(actualClass respondsTo: #createPreferredInstanceBy:) willReturn: #result]
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testCreationAppropriateInstanceWhenNoSubclasses [

	[:sample |
		[(class appropriateInstanceInContextOf: #someObject) should be: #result]
			should strictly satisfy: 
		[actualClass allSubclasses willReturn: #().
		actualClass new willReturn: sample.
		sample readSampleProperitiesFrom: #someObject.
		(sample canBePrototypeInContextOf: #someObject) willReturn: true.
		actualClass new willReturn: #result]
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testCreationAppropriateInstanceWhenNoSubclassesAndActualClassNotGood [

	[:sample |
		actualClass stub allSubclasses willReturn: #().
		actualClass stub new willReturn: sample.
		(sample stub canBePrototypeInContextOf: #someObject) willReturn: false.
		
		[class appropriateInstanceInContextOf: #someObject] 
			should raise: PtyNoAppropriatePrototypeError.
			 
		[sample readSampleProperitiesFrom: #someObject.
		sample stub canBePrototypeInContextOf: #someObject] should beDoneInOrder
	
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testCreationAppropriateInstanceWhenSubclassesExists [

	[:class1 :class2 :sample |
		[(class appropriateInstanceInContextOf: #someObject) should be: #result]
			should strictly satisfy: 
		[actualClass allSubclasses willReturn: {class1. class2}.
		class2 new willReturn: sample.
		sample readSampleProperitiesFrom: #someObject.
		(sample canBePrototypeInContextOf: #someObject) willReturn: true.
		class2 new willReturn: #result]
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testCreationAppropriateInstanceWhenSubclassesExistsButAllAndActualClassNotGood [

	[:class1 :class2 :badSample1 :badSample2 :badSample3 |
		[actualClass allSubclasses willReturn: {class1. class2}.
		class2 new willReturn: badSample2.
		(badSample2 canBePrototypeInContextOf: #someObject) willReturn: false.
		class1 new willReturn: badSample1.
		(badSample1 canBePrototypeInContextOf: #someObject) willReturn: false.
		actualClass new willReturn: badSample3.
		(badSample3 canBePrototypeInContextOf: #someObject) willReturn: false]
			should expect.
		
		[class appropriateInstanceInContextOf: #someObject]
			should raise: PtyNoAppropriatePrototypeError
					
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testCreationAppropriateInstanceWhenSubclassesExistsButAllNotGood [

	[:class1 :badSample :goodSample |
		[(class appropriateInstanceInContextOf: #someObject) should be: #result]
			should strictly satisfy: 
		[actualClass allSubclasses willReturn: {class1}.
		class1 new willReturn: badSample.
		badSample readSampleProperitiesFrom: #someObject.
		(badSample canBePrototypeInContextOf: #someObject) willReturn: false.
		actualClass new willReturn: goodSample.
		goodSample readSampleProperitiesFrom: #someObject.
		(goodSample canBePrototypeInContextOf: #someObject) willReturn: true.
		actualClass new willReturn: #result]
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testCreationAppropriateInstanceWhenSubclassesExistsButNotAllGood [

	[:class1 :class2 :class3 :badSample :goodSample |
		[(class appropriateInstanceInContextOf: #someObject) should be: #result]
			should strictly satisfy: 
		[actualClass allSubclasses willReturn: {class1. class2. class3}.
		class3 new willReturn: badSample.
		badSample readSampleProperitiesFrom: #someObject.
		(badSample canBePrototypeInContextOf: #someObject) willReturn: false.
		class2 new willReturn: goodSample.
		goodSample readSampleProperitiesFrom: #someObject.
		(goodSample canBePrototypeInContextOf: #someObject) willReturn: true.
		class2 new willReturn: #result]
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testCreationPreferredInstance [

	[
		[(class createPreferredInstanceBy: #userPrototypeFactory) should be: #result]
			should strictly satisfy: 
		[(actualClass createPreferredInstanceBy: #userPrototypeFactory) willReturn: #result]
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testGettingNameWhenNoSpecialNameDefined [

	[
		[class name should be: #className]
			should strictly satisfy: 
		[actualClass name willReturn: #className]
	] runWithMocks 

]

{ #category : #tests }
PtyPrototypeClassTests >> testGettingNameWhenSpecialNameDefined [

	class name: #specialName.
	
	class name should be: #specialName
]
