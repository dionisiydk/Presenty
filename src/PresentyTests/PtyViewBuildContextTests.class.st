Class {
	#name : #PtyViewBuildContextTests,
	#superclass : #TestCase,
	#instVars : [
		'context',
		'prototype',
		'presenter'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyViewBuildContextTests >> setUp [
	super setUp.
	prototype := Mock new.
	presenter := Mock new.
	context := PtyViewBuildContext presenter: presenter prototype: prototype.
]

{ #category : #tests }
PtyViewBuildContextTests >> testPrintingViewNameForPresenterWithoutStyle [

	[
		[context printPresenterViewName should equal: 'prototype of name']
			should lenient satisfy: 
		[presenter hasStyle willReturn: false.
		presenter prototypeContextName willReturn: #name]
	
	] runWithMocks 
]

{ #category : #tests }
PtyViewBuildContextTests >> testPrintingViewNameForStyledPresenter [

	[
		[context printPresenterViewName should equal: 'prototype of name']
			should lenient satisfy: 
		[presenter hasStyle willReturn: true.
		presenter prototypeStyleContextName willReturn: #name]
	
	] runWithMocks 
]

{ #category : #tests }
PtyViewBuildContextTests >> testSavingViewAsPrototype [

	[:view| 
		[context saveAsPrototype: view]
			should lenient satisfy: 
		[prototype saveNewSample: view]
	
	] runWithMocks 
]
