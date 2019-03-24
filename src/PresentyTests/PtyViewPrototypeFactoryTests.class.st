Class {
	#name : #PtyViewPrototypeFactoryTests,
	#superclass : #PtyPrototypeFactoryTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyViewPrototypeFactoryTests >> factoryClass [ 
	^PtyViewPrototypeFactory 
]

{ #category : #tests }
PtyViewPrototypeFactoryTests >> testCreationPrototypeForPresenter [

	| actual |
	[:presenter |
		[actual := factory createPrototypeFor: presenter]
			should strictly satisfy: 
		[presenter defaultView willReturn: #view].
		
		actual should beInstanceOf: PtyPrototype.
		actual sample should be: #view
	] runWithMocks 
]
