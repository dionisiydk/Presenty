Class {
	#name : #PtyTaskReturnRequestTests,
	#superclass : #PtyTaskActivationRequestTestCase,
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyTaskReturnRequestTests >> requestClass [ 
	^PtyTaskReturnRequest
]

{ #category : #tests }
PtyTaskReturnRequestTests >> testExecution [ 

	| actual |

	[:guide :currentContext |
		request returnValue: #result.

		[(request executeBy: guide inContext: taskContext) should be: #result]
			should strictly satisfy: 
		[guide context willReturn: currentContext.
		(currentContext prepareReturnContextTo: taskContext) willReturn: #returnContext.
		guide context: #returnContext]
	] runWithMocks
]
