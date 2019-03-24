Class {
	#name : #PtyParentRelationPrototypeContextTestCase,
	#superclass : #PtyBasePrototypeContextTestCase,
	#category : #PrototypesManagerTests
}

{ #category : #testing }
PtyParentRelationPrototypeContextTestCase class >> isAbstract [ 
	^self == PtyParentRelationPrototypeContextTestCase 
]

{ #category : #tests }
PtyParentRelationPrototypeContextTestCase >> testGettingName [
	
	[
		[context name should be: #result]
			should strictly satisfy: 
		[subject prototypeContextName willReturn: #result].
		
	] runWithMocks 
]

{ #category : #tests }
PtyParentRelationPrototypeContextTestCase >> testGettingParent [
	
	| actual |
	[
		[actual := context parent]
			should strictly satisfy: 
		[subject parent willReturn: #parent].
	
		actual should beInstanceOf: self contextClass.
		actual subject should be: #parent
	] runWithMocks 
	
]

{ #category : #tests }
PtyParentRelationPrototypeContextTestCase >> testGettingParentWhenItAbsent [
	
	| actual |
	[
		[actual := context parent]
			should strictly satisfy: 
		[subject parent willReturn: nil].
	
		actual should be: nil
	] runWithMocks 
	
]
