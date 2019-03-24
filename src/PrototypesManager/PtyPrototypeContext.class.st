Class {
	#name : #PtyPrototypeContext,
	#superclass : #Object,
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyPrototypeContext class >> of: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
PtyPrototypeContext >> contextClass [ 
	^self class
]

{ #category : #accessing }
PtyPrototypeContext >> createContextGroup [
	^PtyConcreteContextClassGroup new
]

{ #category : #accessing }
PtyPrototypeContext >> createLookupWith: nextContextLookup [

	| lookup |
	lookup := PtyPrototypesLookup inContext: self withNextLookup: nextContextLookup.
	nextContextLookup parentContextLookup: lookup.
	^lookup
]

{ #category : #printing }
PtyPrototypeContext >> printName [
	^self printString 
]
