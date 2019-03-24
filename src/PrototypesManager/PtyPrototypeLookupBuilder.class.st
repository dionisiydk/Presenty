Class {
	#name : #PtyPrototypeLookupBuilder,
	#superclass : #Object,
	#instVars : [
		'prototypeFactory',
		'contextsProvider'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyPrototypeLookupBuilder class >> with: aPrototypeFactory [

	^self new 
		prototypeFactory: aPrototypeFactory 
]

{ #category : #building }
PtyPrototypeLookupBuilder >> buildLookupFor: anObject [
	
	^anObject basePrototypeContexts 
		inject: prototypeFactory defaultPrototypeLookup 
		into: [:lookup :eachContext | | parentLookup |
				parentLookup := eachContext createLookupWith: lookup.
				parentLookup createFullLookupChainBy:  contextsProvider]
]

{ #category : #accessing }
PtyPrototypeLookupBuilder >> contextsProvider [
	^ contextsProvider
]

{ #category : #accessing }
PtyPrototypeLookupBuilder >> contextsProvider: anObject [
	contextsProvider := anObject
]

{ #category : #building }
PtyPrototypeLookupBuilder >> convert: aPrototypesLookup toContextGroupsOf: anObject [

	| lookup contexts groups nextContext currentGroup |
	lookup := aPrototypesLookup.
	contexts := anObject basePrototypeContexts reversed readStream.
	groups := OrderedCollection new.
	nextContext := contexts next.
	
	[lookup isKindOf: PtyDefaultPrototypeLookup] whileFalse: [
		(nextContext notNil and: [lookup hasContextLike: nextContext]) ifTrue: [
			currentGroup := OrderedCollection new.
			groups add: nextContext -> currentGroup.
			nextContext := contexts next.
		].
		currentGroup add: lookup.	
		lookup := lookup nextContextLookup
	].

	^groups
	
]

{ #category : #'initialize-release' }
PtyPrototypeLookupBuilder >> initialize [ 
	super initialize.
	
	contextsProvider := PtyDomainContextsProvider new
	
]

{ #category : #accessing }
PtyPrototypeLookupBuilder >> prototypeFactory [
	^ prototypeFactory
]

{ #category : #accessing }
PtyPrototypeLookupBuilder >> prototypeFactory: anObject [
	prototypeFactory := anObject
]
