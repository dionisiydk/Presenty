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
	^[ | result |
		result := internalExecutionStrategy requestExecutionOf: aTask using: aWorker.
		shouldReturnToParentToCompleteSeparation 
			ifTrue: [result] ifFalse: [PtyUserRequest signal]
	] ensure: [ shouldReturnToParentToCompleteSeparation := false]
]
