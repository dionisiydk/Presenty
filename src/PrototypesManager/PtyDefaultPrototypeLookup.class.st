Class {
	#name : #PtyDefaultPrototypeLookup,
	#superclass : #Object,
	#instVars : [
		'parentContextLookup',
		'prototypeFactory'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyDefaultPrototypeLookup class >> with: aPrototypeFactory [

	^self new 
		prototypeFactory: aPrototypeFactory 
]

{ #category : #converting }
PtyDefaultPrototypeLookup >> asArray [
	^#()
]

{ #category : #accessing }
PtyDefaultPrototypeLookup >> parentContextLookup [
	^ parentContextLookup
]

{ #category : #accessing }
PtyDefaultPrototypeLookup >> parentContextLookup: aPtyPrototypesLookup [ 
	parentContextLookup := aPtyPrototypesLookup 
]

{ #category : #accessing }
PtyDefaultPrototypeLookup >> prototypeFactory [
	^ prototypeFactory
]

{ #category : #accessing }
PtyDefaultPrototypeLookup >> prototypeFactory: anObject [
	prototypeFactory := anObject
]

{ #category : #lookup }
PtyDefaultPrototypeLookup >> searchPrototypeFor: anObject in: aPrototypesCollection [

	| prototype |

	aPrototypesCollection defaultPrototype ifNotNilDo: [:v | 
		(prototypeFactory canPrototype: v supplyInstancesFor: anObject)
			ifTrue: [^v]].
	
	prototype := prototypeFactory createPrototypeFor: anObject.
	prototype collection: aPrototypesCollection.
	^prototype
]
