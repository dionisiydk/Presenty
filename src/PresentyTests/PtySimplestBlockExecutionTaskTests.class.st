Class {
	#name : #PtySimplestBlockExecutionTaskTests,
	#superclass : #PtyTaskTestCase,
	#category : #'PresentyTests-BlockExecutionTasks'
}

{ #category : #running }
PtySimplestBlockExecutionTaskTests >> taskClass [
	^PtySimplestBlockExecutionTask 
]

{ #category : #tests }
PtySimplestBlockExecutionTaskTests >> testExecution [

	[:block |
		task block: block.
		
		[task body]
			should strictly satisfy: 
		[block value]
				
	] runWithMocks 
]
