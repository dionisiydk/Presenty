Class {
	#name : #PtySeparateWorkflowExecutionStrategyTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#instVars : [
		'internalStrategy'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtySeparateWorkflowExecutionStrategyTest >> createStrategy [
	^PtySeparateWorkflowExecutionStrategy new
]

{ #category : #running }
PtySeparateWorkflowExecutionStrategyTest >> setUp [
	super setUp.
	
	internalStrategy := Mock new.
	strategy internalExecutionStrategy: internalStrategy
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldDelegateExecutionToInternalStrategy [ 

	| result |
	result := strategy requestExecutionOf: task using: worker.
	
	result should beReturnedFrom: [internalStrategy requestExecutionOf: task using: worker]
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldSpawnTaskWorkflowBeforeExecution [

	strategy requestExecutionOf: task using: worker.
	
	[task spawnWorkflow.
	internalStrategy requestExecutionOf: task using: worker] should beDoneInOrder
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldStopExecutionForRepeatedTaskReturns [ 
	| executionWasStopped continuation result |
	executionWasStopped := false.
	(internalStrategy stub requestExecutionOf: task using: worker) will: [
		Continuation currentDo: [ :cc | continuation := cc. #initialResult]
	].
	
	[result := strategy requestExecutionOf: task using: worker.
	result = #initialResult ifTrue: [continuation value: #newResult]] 
		on: PtyUserRequest do: [ :exc | executionWasStopped := true ].
	
	executionWasStopped should be: true
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldStopExecutionForRepeatedTaskReturnsWhenFirstWasUserRequest [
	| userRequestCounter continuation |
	userRequestCounter := 0.
	(internalStrategy stub requestExecutionOf: task using: worker) will: [ | returnAction |
		returnAction := Continuation currentDo: [ :cc | continuation := cc. [PtyUserRequest signal]].
		returnAction value
	].
	
	[strategy requestExecutionOf: task using: worker] 
		on: PtyUserRequest do: [ :exc | userRequestCounter := userRequestCounter + 1 ].
	userRequestCounter = 1 ifTrue: [ continuation value: [#newResult]].	
	userRequestCounter should be: 2
]
