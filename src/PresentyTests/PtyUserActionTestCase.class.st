Class {
	#name : #PtyUserActionTestCase,
	#superclass : #TestCase,
	#instVars : [
		'action',
		'presenter'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #testing }
PtyUserActionTestCase class >> isAbstract [ 
	^self == PtyUserActionTestCase
]

{ #category : #running }
PtyUserActionTestCase >> setUp [ 
	super setUp.
	
	presenter := Mock new.
	action := self userActionClass new.
	action presenter: presenter 
]

{ #category : #running }
PtyUserActionTestCase >> userActionClass [
	self subclassResponsibility 
]
