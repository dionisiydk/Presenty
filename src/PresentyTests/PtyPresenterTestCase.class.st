Class {
	#name : #PtyPresenterTestCase,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'guide',
		'presenterView'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #testing }
PtyPresenterTestCase class >> isAbstract [
	^self = PtyPresenterTestCase 
]

{ #category : #running }
PtyPresenterTestCase >> createPresenter [
	self subclassResponsibility 
]

{ #category : #running }
PtyPresenterTestCase >> setUp [
	super setUp.
	
	guide := Mock new.
	presenterView := Mock new.
	presenter := self createPresenter.
	presenter guide: guide.
	presenter view: presenterView
]
