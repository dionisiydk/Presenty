Class {
	#name : #PtySecreteValuePrinter,
	#superclass : #PtyValuePrinter,
	#instVars : [
		'secreteMask',
		'secreteChar'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #accessing }
PtySecreteValuePrinter >> editDecorator [ 
	^PtySecreteEditDecorator new
]

{ #category : #'initialize-release' }
PtySecreteValuePrinter >> initialize [ 
	super initialize.
	
	secreteChar := $*
]

{ #category : #printing }
PtySecreteValuePrinter >> printValue: aString [

	| result |
	aString ifNil: [^''].
		
	result := (String new: aString size) atAllPut: secreteChar.
	secreteMask ifNil: [^result].
	
	secreteMask withIndexDo: [:char :i | 
		i > aString size ifTrue: [^result].
		char = $x ifTrue: [result at: i put: (aString at: i)]
	].
	
	^result 
]

{ #category : #accessing }
PtySecreteValuePrinter >> secreteChar [
	^ secreteChar
]

{ #category : #accessing }
PtySecreteValuePrinter >> secreteChar: anObject [
	secreteChar := anObject
]

{ #category : #accessing }
PtySecreteValuePrinter >> secreteMask [
	^ secreteMask
]

{ #category : #accessing }
PtySecreteValuePrinter >> secreteMask: anObject [
	secreteMask := anObject
]
