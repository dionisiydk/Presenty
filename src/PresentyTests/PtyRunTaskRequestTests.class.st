Class {
	#name : #PtyRunTaskRequestTests,
	#superclass : #PtyTaskActivationRequestTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyRunTaskRequestTests >> requestClass [ 
	^PtyRunTaskRequest 
]

{ #category : #tests }
PtyRunTaskRequestTests >> testExecution [ 

	[:guide :activation |
		[(request executeBy: guide inContext: taskContext) should be: #result]
			should strictly satisfy: 
		[guide context: taskContext.
		taskContext activation willReturn: activation.
		activation setUpNewViewArea.
		task body willReturn: #result]
	] runWithMocks 
]
