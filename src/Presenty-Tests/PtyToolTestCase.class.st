Class {
	#name : #PtyToolTestCase,
	#superclass : #TestCase,
	#instVars : [
		'tool'
	],
	#category : #'Presenty-Tests-Tools'
}

{ #category : #testing }
PtyToolTestCase class >> isAbstract [ 
	^self = PtyToolTestCase
]
