Class {
	#name : #PtyArbitraryContextsGroup,
	#superclass : #PtyPrototypeContextsGroup,
	#category : #PrototypesManager
}

{ #category : #'initialize-release' }
PtyArbitraryContextsGroup >> initialize [ 
	super initialize.
	
	contents := OrderedCollection new
]

{ #category : #accessing }
PtyArbitraryContextsGroup >> prototypesFor: anObject inContextOf: aPrototypeContext [
	| result |
	result := contents detect: [:each | each key isActiveFor: anObject] ifNone: [nil].
	result ifNil: [^nil].
	
	^result value
]

{ #category : #accessing }
PtyArbitraryContextsGroup >> remove: aPrototypesCollection [ 
	
	contents removeAllSuchThat: [:each | each value == aPrototypesCollection ]
]
