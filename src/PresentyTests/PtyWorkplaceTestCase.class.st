Class {
	#name : #PtyWorkplaceTestCase,
	#superclass : #TestCase,
	#instVars : [
		'workplace'
	],
	#category : #'PresentyTests-NewCore'
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
