Class {
	#name : #PtyEditDecoratorTestCase,
	#superclass : #TestCase,
	#instVars : [
		'decorator'
	],
	#category : #'PresentyTests-UI'
}

{ #category : #accessing }
PtyEditDecoratorTestCase class >> isAbstract [ 

	^self = PtyEditDecoratorTestCase
]

{ #category : #running }
PtyEditDecoratorTestCase >> setUp [
	super setUp.
	
	decorator := self decoratorClass new.
]

{ #category : #tests }
PtyEditDecoratorTestCase >> testShouldHasEmptyDecoratedValueByDefault [
	
	decorator decoratedValue should equal: ''
]
