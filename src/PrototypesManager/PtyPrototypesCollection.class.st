Class {
	#name : #PtyPrototypesCollection,
	#superclass : #Object,
	#instVars : [
		'parent',
		'childContexts',
		'defaultPrototype'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyPrototypesCollection class >> parent: aPrototypeContextsGroup [ 

	^self new 
		parent: aPrototypeContextsGroup 	
]

{ #category : #accessing }
PtyPrototypesCollection >> add: aPrototype to: aPrototypeContext [
	| group copy |
	group := childContexts at: aPrototypeContext contextClass	ifAbsentPut: [
				aPrototypeContext createContextGroup 
					parent: self; yourself].
	
	copy := aPrototype createCopy.
	
	group add: copy to: aPrototypeContext.
	
	^copy
]

{ #category : #testing }
PtyPrototypesCollection >> belongsTo: aPrototypeContext [ 
	parent ifNil: [^false].
	
	(parent has: self at: aPrototypeContext) 
		ifTrue: [^true].
		
	^parent belongsTo: aPrototypeContext 
]

{ #category : #accessing }
PtyPrototypesCollection >> childContexts [
	^ childContexts
]

{ #category : #accessing }
PtyPrototypesCollection >> childContexts: anObject [
	childContexts := anObject
]

{ #category : #accessing }
PtyPrototypesCollection >> defaultPrototype [
	^ defaultPrototype
]

{ #category : #accessing }
PtyPrototypesCollection >> defaultPrototype: aPrototype [
	defaultPrototype := aPrototype.
	defaultPrototype collection: self
	
]

{ #category : #accessing }
PtyPrototypesCollection >> delete [
	
	childContexts ifNotEmpty: [
		self notify: 'There are ', childContexts size asString, ' child contexts!'].

	parent ifNil: [^self].	
		
	parent removeChild: self
]

{ #category : #accessing }
PtyPrototypesCollection >> findParentWhichBelongsTo: aPrototypeContext [ 
	parent ifNil: [^nil].
	
	(parent belongsTo: aPrototypeContext) 
		ifTrue: [^parent].
		
	^parent findParentWhichBelongsTo: aPrototypeContext 
]

{ #category : #testing }
PtyPrototypesCollection >> has: aPrototypesCollection at: aPrototypeContext [
	
	| group |
	group := childContexts at: aPrototypeContext contextClass ifAbsent: [^false].
	
	^group has: aPrototypesCollection at: aPrototypeContext
]

{ #category : #testing }
PtyPrototypesCollection >> includedToParentAt: aPrototypeContext [ 
	parent ifNil: [^false].
	
	^parent has: self at: aPrototypeContext
]

{ #category : #'initialize-release' }
PtyPrototypesCollection >> initialize [ 
	super initialize.
	
	childContexts := Dictionary new.
]

{ #category : #accessing }
PtyPrototypesCollection >> parent [
	^ parent
]

{ #category : #accessing }
PtyPrototypesCollection >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
PtyPrototypesCollection >> prototypesFor: anEntity inContextOf: aPrototypeContext [
	
	| group result |
	childContexts ifEmpty: [^self].
	
	group := childContexts at: aPrototypeContext contextClass ifAbsent: [^self].
	
	result := group prototypesFor: anEntity inContextOf: aPrototypeContext.
	
	result ifNil: [^self].
	
	^result

]

{ #category : #accessing }
PtyPrototypesCollection >> removeChild: aPrototypesCollection [ 

	childContexts do: [:each | each remove: aPrototypesCollection]
]

{ #category : #accessing }
PtyPrototypesCollection >> removeDefaultPrototype [
	defaultPrototype := nil
]

{ #category : #accessing }
PtyPrototypesCollection >> root [
	^parent ifNil: [self] ifNotNil: [parent root]
]
