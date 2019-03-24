Class {
	#name : #PtyConcreteContextClassGroup,
	#superclass : #PtyPrototypeContextsGroup,
	#category : #PrototypesManager
}

{ #category : #accessing }
PtyConcreteContextClassGroup >> add: aPrototype to: aPrototypeContext [

	| targetCollection |
	targetCollection := contents at: aPrototypeContext name 
				ifAbsentPut: [PtyPrototypesCollection parent: parent].
				
	targetCollection defaultPrototype: aPrototype 
]

{ #category : #testing }
PtyConcreteContextClassGroup >> has: aPrototypeCollection at: aPrototypeContext [

	| contextPrototypes |
	contextPrototypes := contents at: aPrototypeContext name ifAbsent: [^false].
	^contextPrototypes == aPrototypeCollection
]

{ #category : #'initialize-release' }
PtyConcreteContextClassGroup >> initialize [ 
	super initialize.
	
	contents := Dictionary new
]

{ #category : #accessing }
PtyConcreteContextClassGroup >> prototypesFor: anObject inContextOf: aPrototypeContext [
	^contents at: aPrototypeContext name ifAbsent: [nil].
]

{ #category : #accessing }
PtyConcreteContextClassGroup >> remove: aPrototypesCollection [ 

	contents removeKey: (contents keyAtValue: aPrototypesCollection ifAbsent: [^self])
]
