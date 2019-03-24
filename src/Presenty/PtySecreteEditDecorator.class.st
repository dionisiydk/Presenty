Class {
	#name : #PtySecreteEditDecorator,
	#superclass : #PtyNoneEditDecorator,
	#instVars : [
		'secreteChar',
		'secreteMask'
	],
	#category : #'Presenty-UI'
}

{ #category : #'instance creation' }
PtySecreteEditDecorator class >> with: secreteMaskString [

	^self new 
		secreteMask: secreteMaskString
]

{ #category : #evaluating }
PtySecreteEditDecorator >> decoratedValue [ 
	| result |
	result := (String new: decoratedValue size) atAllPut: secreteChar.
	secreteMask ifNil: [^result].
	
	secreteMask withIndexDo: [:char :i | 
		i > decoratedValue size ifTrue: [^result].
		char = $x ifTrue: [result at: i put: (decoratedValue at: i)]
	].
	
	^result 
]

{ #category : #'initialize-release' }
PtySecreteEditDecorator >> initialize [ 
	super initialize.
	
	secreteChar := $*
]

{ #category : #accessing }
PtySecreteEditDecorator >> secreteChar [
	^ secreteChar
]

{ #category : #accessing }
PtySecreteEditDecorator >> secreteChar: anObject [
	secreteChar := anObject
]

{ #category : #accessing }
PtySecreteEditDecorator >> secreteMask [
	^ secreteMask
]

{ #category : #accessing }
PtySecreteEditDecorator >> secreteMask: anObject [
	secreteMask := anObject
]
