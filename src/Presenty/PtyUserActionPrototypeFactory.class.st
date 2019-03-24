Class {
	#name : #PtyUserActionPrototypeFactory,
	#superclass : #PtyPrototypeFactory,
	#category : #'Presenty-Core'
}

{ #category : #testing }
PtyUserActionPrototypeFactory >> canPrototype: aPrototype supplyInstancesFor: anUserAction [

	^(anUserAction connectorPrototype == aPrototype) not
]

{ #category : #'prototypes creation' }
PtyUserActionPrototypeFactory >> createPrototypeFor: aPresenter [

	^PtyPrototype sample: PtyUserActionConnector new
]
