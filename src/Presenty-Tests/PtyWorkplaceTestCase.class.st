Class {
	#name : #PtyWorkplaceTestCase,
	#superclass : #TestCase,
	#instVars : [
		'workplace'
	],
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #testing }
PtyWorkplaceTestCase class >> isAbstract [ 
	^self = PtyWorkplaceTestCase 
]

{ #category : #running }
PtyWorkplaceTestCase >> setUp [
	super setUp.
	
	workplace := PtyWorkplace new.
]
