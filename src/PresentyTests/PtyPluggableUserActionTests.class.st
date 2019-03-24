Class {
	#name : #PtyPluggableUserActionTests,
	#superclass : #PtyUserActionTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #tests }
PtyPluggableUserActionTests >> testCreationFromBlock [

	| block actual |
	block := ['test block'].
	
	actual := block asUserAction.
	
	actual should beInstanceOf: self userActionClass.
	actual block should be: block
]

{ #category : #tests }
PtyPluggableUserActionTests >> testExecution [

	[:block | 
		action block: block.
		
		[action execute]
			should strictly satisfy: 
		[block cull: presenter]
	
	] runWithMocks 
]

{ #category : #running }
PtyPluggableUserActionTests >> userActionClass [
	^PtyPluggableUserAction
]
