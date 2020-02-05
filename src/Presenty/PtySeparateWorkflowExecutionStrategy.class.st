Class {
	#name : #PtySeparateWorkflowExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#instVars : [
		'internalExecutionStrategy'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtySeparateWorkflowExecutionStrategy >> internalExecutionStrategy [
	^ internalExecutionStrategy
]

{ #category : #accessing }
PtySeparateWorkflowExecutionStrategy >> internalExecutionStrategy: anObject [
	internalExecutionStrategy := anObject
]

{ #category : #'task execution' }
PtySeparateWorkflowExecutionStrategy >> requestExecutionOf: aTask using: aWorker [
	| shouldReturnToParentToCompleteSeparation |
	shouldReturnToParentToCompleteSeparation := true.
	aTask spawnWorkflow.	
	^[ 
		[internalExecutionStrategy requestExecutionOf: aTask using: aWorker]
			on: PtyUserRequest do: [ :exc | 
				shouldReturnToParentToCompleteSeparation 
					ifTrue: [PtyTaskExecutionFutureResult of: aTask ] 
					ifFalse: [exc pass] ].
		shouldReturnToParentToCompleteSeparation 
			ifTrue: [PtyTaskExecutionFutureResult of: aTask ] 
			ifFalse: [PtyUserRequest signal]
	] ensure: [ shouldReturnToParentToCompleteSeparation := false]
]
