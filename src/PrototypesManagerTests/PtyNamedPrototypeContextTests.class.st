Class {
	#name : #PtyNamedPrototypeContextTests,
	#superclass : #PtyDomainPrototypeContextTestCase,
	#category : #PrototypesManagerTests
}

{ #category : #running }
PtyNamedPrototypeContextTests >> contextClass [ 
	^PtyNamedPrototypeContext 
]

{ #category : #tests }
PtyNamedPrototypeContextTests >> testGettingName [

	context name: #contextName.
	
	context name should be: #contextName
]
