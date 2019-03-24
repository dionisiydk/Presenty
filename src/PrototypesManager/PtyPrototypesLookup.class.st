Class {
	#name : #PtyPrototypesLookup,
	#superclass : #Object,
	#instVars : [
		'context',
		'nextContextLookup',
		'parentContextLookup'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyPrototypesLookup class >> inContext: aPrototypeContext withNextLookup: aPrototypesLookup [

	^self new 
		context: aPrototypeContext;
		nextContextLookup: aPrototypesLookup 
]

{ #category : #converting }
PtyPrototypesLookup >> asArray [
	^(Array with: self ), nextContextLookup asArray 
]

{ #category : #accessing }
PtyPrototypesLookup >> context [
	^ context
]

{ #category : #accessing }
PtyPrototypesLookup >> context: anObject [
	context := anObject
]

{ #category : #accessing }
PtyPrototypesLookup >> createFullLookupChainBy: aDomainContextsProvider [
	| parentContext |
	self detectDomainContextsBy: aDomainContextsProvider.
		
	parentContext := context parent.
	parentContext ifNil: [ ^ self ].
	
	parentContextLookup := parentContext createLookupWith: self.
	
	^ parentContextLookup createFullLookupChainBy: aDomainContextsProvider
]

{ #category : #accessing }
PtyPrototypesLookup >> detectDomainContextsBy: aDomainContextsProvider [

	nextContextLookup := context 
		createDomainContextsLookupBy: aDomainContextsProvider with: nextContextLookup.
	nextContextLookup parentContextLookup: self
	
	
]

{ #category : #testing }
PtyPrototypesLookup >> hasContextLike: aPrototypeContext [ 
	^context isKindOf: aPrototypeContext contextClass 
]

{ #category : #accessing }
PtyPrototypesLookup >> nextContextLookup [
	^ nextContextLookup
]

{ #category : #accessing }
PtyPrototypesLookup >> nextContextLookup: anObject [
	nextContextLookup := anObject
]

{ #category : #accessing }
PtyPrototypesLookup >> parentContextLookup [
	^ parentContextLookup
]

{ #category : #accessing }
PtyPrototypesLookup >> parentContextLookup: anObject [
	parentContextLookup := anObject
]

{ #category : #lookup }
PtyPrototypesLookup >> searchPrototypeFor: anObject in: aPrototypesCollection [

	| specificContextPrototypes |

	specificContextPrototypes := aPrototypesCollection prototypesFor: anObject inContextOf: context.

	^nextContextLookup searchPrototypeFor: anObject in: specificContextPrototypes
]
