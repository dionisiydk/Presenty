Class {
	#name : #PtyPresenterDecoratorFactory,
	#superclass : #PtyPresenterFactory,
	#instVars : [
		'actualFactory'
	],
	#category : #'Presenty-ShowListTasks'
}

{ #category : #'instance creation' }
PtyPresenterDecoratorFactory class >> on: aPresenterFactory [

	^self new 
		actualFactory: aPresenterFactory 
]

{ #category : #accessing }
PtyPresenterDecoratorFactory >> actualFactory [
	^ actualFactory
]

{ #category : #accessing }
PtyPresenterDecoratorFactory >> actualFactory: anObject [
	actualFactory := anObject
]

{ #category : #convertion }
PtyPresenterDecoratorFactory >> convertTo: aPresenterFactory [

	actualFactory := aPresenterFactory.
	
	^self
]
