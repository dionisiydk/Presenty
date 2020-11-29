Class {
	#name : #PtySeparateWorkflowExecutionStrategyTest,
	#superclass : #PtyTaskExecutionStrategyTestCase,
	#instVars : [
		'actualWorkflowStrategy',
		'spawnedWorkflow'
	],
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtySeparateWorkflowExecutionStrategyTest >> createStrategy [
	^PtySeparateWorkflowExecutionStrategy new
]

{ #category : #running }
PtySeparateWorkflowExecutionStrategyTest >> setUp [
	super setUp.
	
	actualWorkflowStrategy := Mock new.
	strategy actualWorkflowExecutionStrategy: actualWorkflowStrategy.
	
	spawnedWorkflow := Mock new.
	task stub workflow willReturn: spawnedWorkflow
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldDelegateExecutionToInternalStrategyWithSpawnedWorkflow [ 

	strategy requestExecutionOf: task in: workflow.
	
	actualWorkflowStrategy should receive requestExecutionOf: task in: spawnedWorkflow
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldInterceptUserRequestFromFirstTaskReturn [ 
	
	| result |
	(actualWorkflowStrategy stub requestExecutionOf: task in: spawnedWorkflow) 
		willRaise: PtyUserRequest new.
	
	result := strategy requestExecutionOf: task in: workflow.
	
	result should beKindOf: PtyTaskExecutionFutureResult.
	result task should be: task
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldReturnFutureResultForFirstTaskReturn [

	| result |
	result := strategy requestExecutionOf: task in: workflow.
	
	result should beKindOf: PtyTaskExecutionFutureResult.
	result task should be: task
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldSpawnTaskWorkflowBeforeExecution [

	strategy requestExecutionOf: task in: workflow.
	
	[task spawnWorkflow.
	actualWorkflowStrategy requestExecutionOf: task in: spawnedWorkflow] should beDoneInOrder
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldStopExecutionForRepeatedTaskReturns [ 
	| numberOfTaskReturns continuation executionWasStopped |
	numberOfTaskReturns := 0.
	executionWasStopped := false.
	(actualWorkflowStrategy stub requestExecutionOf: task in: spawnedWorkflow) 
		will: [ | returnedValue |
			returnedValue := Continuation currentDo: [ :cc | continuation := cc. #initialResult].
			numberOfTaskReturns := numberOfTaskReturns + 1. returnedValue].	
		
	[strategy requestExecutionOf: task in: workflow] 
		on: PtyUserRequest do: [ :exc | executionWasStopped := true ].
	numberOfTaskReturns = 1 ifTrue: [
		executionWasStopped should be: false.
		continuation value: #newResult].
	executionWasStopped should be: true
]

{ #category : #tests }
PtySeparateWorkflowExecutionStrategyTest >> testShouldStopExecutionForRepeatedTaskReturnsWhenFirstWasUserRequest [
	| userRequestCounter continuation numberOfTaskReturns |
	numberOfTaskReturns := 0.
	userRequestCounter := 0.
	(actualWorkflowStrategy stub requestExecutionOf: task in: spawnedWorkflow) 
		will: [ | returnAction |
			returnAction := Continuation currentDo: [ :cc | continuation := cc. [PtyUserRequest signal]].
			numberOfTaskReturns := numberOfTaskReturns + 1.
			returnAction value].
	
	[strategy requestExecutionOf: task in: workflow] 
		on: PtyUserRequest do: [ :exc | userRequestCounter := userRequestCounter + 1 ].
	numberOfTaskReturns = 1 ifTrue: [ 
		userRequestCounter should be: 0.
		continuation value: [#newResult]].	
	userRequestCounter should be: 1
]
