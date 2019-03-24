Class {
	#name : #PtyViewPrototypeFactory,
	#superclass : #PtyPrototypeFactory,
	#category : #'Presenty-Core'
}

{ #category : #'prototypes creation' }
PtyViewPrototypeFactory >> createPrototypeFor: aPresenter [

	^PtyPrototype sample: aPresenter defaultView 
]
