Class {
	#name : #PtyTextConverterTestCase,
	#superclass : #TestCase,
	#instVars : [
		'converter'
	],
	#category : #'PresentyTests-Editor-Fields'
}

{ #category : #testing }
PtyTextConverterTestCase class >> isAbstract [ 
	^self == PtyTextConverterTestCase
]

{ #category : #running }
PtyTextConverterTestCase >> converterClass [
	self subclassResponsibility 
]

{ #category : #running }
PtyTextConverterTestCase >> setUp [
	super setUp.
	
	converter := self converterClass new
]
