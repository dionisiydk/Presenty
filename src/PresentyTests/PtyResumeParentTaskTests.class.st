Class {
	#name : #PtyResumeParentTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyResumeParentTaskTests >> taskClass [

	^PtyResumeParentTask
]

{ #category : #tests }
PtyResumeParentTaskTests >> testExecution [

	[:returnContext |
		task returnContext: returnContext.
		task result: #result.
		
		[task body]
			should strictly satisfy: 
		[returnContext return: #result].
				
	] runWithMocks 
]
