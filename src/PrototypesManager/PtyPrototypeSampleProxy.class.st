Class {
	#name : #PtyPrototypeSampleProxy,
	#superclass : #Object,
	#instVars : [
		'prototype',
		'sample'
	],
	#category : #PrototypesManager
}

{ #category : #'instance creation' }
PtyPrototypeSampleProxy class >> on: aPrototype [
	^self new 
		prototype: aPrototype 
]

{ #category : #'instance creation' }
PtyPrototypeSampleProxy class >> on: aPrototype for: anObject [
	^self new 
		prototype: aPrototype;
		sample: anObject 
]

{ #category : #'as yet unclassified' }
PtyPrototypeSampleProxy >> doesNotUnderstand: aMessage [

	| result |

	(sample respondsTo: aMessage selector) ifTrue: [
		result := aMessage sendTo: sample.
		aMessage hasArguments | (aMessage selector beginsWith: 'request') ifTrue: [
			prototype isAssigned ifFalse: [prototype assignToCollection]].
		^result].
		
	super doesNotUnderstand: aMessage 
	
]

{ #category : #accessing }
PtyPrototypeSampleProxy >> prototype [
	^ prototype
]

{ #category : #accessing }
PtyPrototypeSampleProxy >> prototype: anObject [
	prototype := anObject
]

{ #category : #accessing }
PtyPrototypeSampleProxy >> sample [
	^ sample
]

{ #category : #accessing }
PtyPrototypeSampleProxy >> sample: anObject [
	sample := anObject
]
