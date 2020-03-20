Class {
	#name : #PtySeparateWorkflowExecutionStrategy,
	#superclass : #PtyTaskExecutionStrategy,
	#instVars : [
		'actualWorkflowExecutionStrategy'
	],
	#category : #Presenty
}

{ #category : #'instance creation' }
PtySeparateWorkflowExecutionStrategy class >> using: aTaskExecutionStrategy [
	^self new 
		actualWorkflowExecutionStrategy: aTaskExecutionStrategy 
]

{ #category : #accessing }
PtySeparateWorkflowExecutionStrategy >> actualWorkflowExecutionStrategy [
	^ actualWorkflowExecutionStrategy
]

{ #category : #accessing }
PtySeparateWorkflowExecutionStrategy >> actualWorkflowExecutionStrategy: anObject [
	actualWorkflowExecutionStrategy := anObject
]

{ #category : #'task execution' }
PtySeparateWorkflowExecutionStrategy >> requestExecutionOf: aTask in: aWorkflow [
	"The given task will be executed by actualWorkflowExecutionStrategy.
	The first return from the task (as a simple result or UserRequest signal) should continue the parent task execution. This way the parent will be completed together with aTask.
	But any subsequent returns from the task (using its continuation) should never return to the caller to ensure the separate workflow logic. So the UserRequest will be signalled to prevent parent execution. 
	The first and subsequent returns are distinguished using special flag shouldContinueParentToCompleteSeparation. Being an array it is shared between all continuation resumes. Changing its value in the ensure section affects the continuation instance (created during task execution) and thefore the continuation always resumes with the false value in this temp array"
	| shouldContinueParentToCompleteSeparation |
	shouldContinueParentToCompleteSeparation := Array with: true.
	aTask spawnWorkflow.	
	^[ 
		[actualWorkflowExecutionStrategy requestExecutionOf: aTask in: aTask workflow]
			on: PtyUserRequest do: [ :exc | 
				shouldContinueParentToCompleteSeparation first ifFalse: [exc pass] ].
		shouldContinueParentToCompleteSeparation first 
			ifTrue: [PtyTaskExecutionFutureResult of: aTask ] 
			ifFalse: [PtyUserRequest signal]
	] ensure: [ shouldContinueParentToCompleteSeparation at: 1 put: false]
]
