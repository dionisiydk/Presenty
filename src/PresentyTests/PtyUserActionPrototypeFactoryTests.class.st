Class {
	#name : #PtyUserActionPrototypeFactoryTests,
	#superclass : #PtyPrototypeFactoryTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyUserActionPrototypeFactoryTests >> factoryClass [
	^PtyUserActionPrototypeFactory
]

{ #category : #tests }
PtyUserActionPrototypeFactoryTests >> testCheckingPrototypeWhenUserActionHasDifferentPrototype [

	[:prototype :userAction |
	
		[(factory canPrototype: prototype supplyInstancesFor: userAction) should be: true]
			should strictly satisfy: 
		[userAction connectorPrototype willReturn: #differentPrototype] 
				
	] runWithMocks 
]

{ #category : #tests }
PtyUserActionPrototypeFactoryTests >> testCheckingPrototypeWhenUserActionHasSamePrototype [

	[:prototype :userAction |
	
		[(factory canPrototype: prototype supplyInstancesFor: userAction) should be: false]
			should strictly satisfy: 
		[userAction connectorPrototype willReturn: prototype] 
				
	] runWithMocks 
]

{ #category : #tests }
PtyUserActionPrototypeFactoryTests >> testCreationPrototypeForPresenter [

	| actual |
	
	actual := factory createPrototypeFor: #presenter.

	actual should beInstanceOf: PtyPrototype.
	actual sample should beInstanceOf: PtyUserActionConnector

]
