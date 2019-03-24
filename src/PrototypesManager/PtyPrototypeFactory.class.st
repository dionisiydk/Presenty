Class {
	#name : #PtyPrototypeFactory,
	#superclass : #Object,
	#category : #PrototypesManager
}

{ #category : #testing }
PtyPrototypeFactory >> canPrototype: aPrototype supplyInstancesFor: anObject [
	^true
]

{ #category : #'prototypes creation' }
PtyPrototypeFactory >> createPrototypeFor: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
PtyPrototypeFactory >> defaultPrototypeLookup [
	^PtyDefaultPrototypeLookup with: self
]
