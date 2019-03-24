Class {
	#name : #PtyDomainPrototypeContext,
	#superclass : #PtyPrototypeContext,
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyDomainPrototypeContext class >> basedOn: anObject [

	self subclassResponsibility 
]

{ #category : #testing }
PtyDomainPrototypeContext class >> isActiveFor: anObject [ 
	^false
]
