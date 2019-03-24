Class {
	#name : #PtyStopTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyStopTaskTests >> taskClass [

	^PtyStopTask 
]

{ #category : #tests }
PtyStopTaskTests >> testExecution [

	[
		task targetTaskContext: #targetTaskContext.
		[task body]
			should strictly satisfy: 
		[guide context: #targetTaskContext.
		user stopCurrentTask]
	] runWithMocks 
]
