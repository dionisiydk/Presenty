Class {
	#name : #PtyObjectAspect,
	#superclass : #Object,
	#instVars : [
		'subject',
		'path'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #'instance creation' }
PtyObjectAspect class >> of: anObject path: anArray [

	^self new 
		subject: anObject;
		path: anArray 
]

{ #category : #accessing }
PtyObjectAspect >> path [
	^ path
]

{ #category : #accessing }
PtyObjectAspect >> path: anObject [
	path := anObject
]

{ #category : #accessing }
PtyObjectAspect >> subject [
	^ subject
]

{ #category : #accessing }
PtyObjectAspect >> subject: anObject [
	subject := anObject
]

{ #category : #accessing }
PtyObjectAspect >> value [
	| selector |
	^ path
		inject: subject
		into: [ :s :aspect | 
			s ifNil: [ ^ nil ].
			selector := aspect asSymbol.
			(s respondsTo: selector)
				ifFalse: [ ^ PtyObjectAspectRequest for: aspect ].
			s perform: selector ]
]

{ #category : #accessing }
PtyObjectAspect >> value: anObject [
	| target |
	
	target := path allButLast inject: subject into: [:s :aspect |
		s ifNil: [^self].
		s perform: aspect ].
	
	target ifNil: [^self].
	
	target perform: path last asMutator with: anObject 
]
