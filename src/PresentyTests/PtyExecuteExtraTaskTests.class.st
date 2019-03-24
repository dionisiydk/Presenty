Class {
	#name : #PtyExecuteExtraTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyExecuteExtraTaskTests >> taskClass [
	^PtyExecuteExtraTask 
]

{ #category : #tests }
PtyExecuteExtraTaskTests >> testExecution [

	[:targetTask | 
		task targetTask: targetTask.
		
		[task body]
			should strictly satisfy: 
		[guide requestUserFor: targetTask]
	
	] runWithMocks 
]
