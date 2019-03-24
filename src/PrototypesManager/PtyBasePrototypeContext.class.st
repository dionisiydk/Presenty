Class {
	#name : #PtyBasePrototypeContext,
	#superclass : #PtyPrototypeContext,
	#instVars : [
		'subject'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyBasePrototypeContext class >> of: aPresenter [ 
	^self new 
		subject: aPresenter 
]

{ #category : #accessing }
PtyBasePrototypeContext >> createDomainContextsLookupBy: aDomainContextsProvider with: aPrototypesLookup [

	| domainContexts |
	domainContexts := aDomainContextsProvider searchContextsOf: subject.
	^domainContexts inject: aPrototypesLookup into: [:nextLookup :eachContext |
		eachContext createLookupWith: nextLookup	
	]
]

{ #category : #accessing }
PtyBasePrototypeContext >> name [ 
	self subclassResponsibility 
]

{ #category : #printing }
PtyBasePrototypeContext >> printName [ 
	^self name
]

{ #category : #accessing }
PtyBasePrototypeContext >> subject [
	^ subject
]

{ #category : #accessing }
PtyBasePrototypeContext >> subject: anObject [
	subject := anObject
]
