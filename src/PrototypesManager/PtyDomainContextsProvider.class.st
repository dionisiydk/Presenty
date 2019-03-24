Class {
	#name : #PtyDomainContextsProvider,
	#superclass : #Object,
	#category : #PrototypesManager
}

{ #category : #'searching contexts' }
PtyDomainContextsProvider >> searchContextsOf: anObject [

	| result |
	result := OrderedCollection new.
	
	PtyDomainPrototypeContext allSubclassesDo: [:eachContextClass | 
		(eachContextClass isActiveFor: anObject)
			ifTrue: [result add: (eachContextClass basedOn: anObject)] 
		].
	^result
]
