Class {
	#name : #PtyUserTest,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'user'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyUserTest >> setUp [
	super setUp.

	workplace := Mock new.
	user := PtyUser of: workplace
]

{ #category : #'as yet unclassified' }
PtyUserTest >> testConfirm [
	
	| task |
	[
		[(user confirm: #message) should be: #result]  
			should strictly satisfy: 
		[(guide requestUserFor: (Instance of: PtyShowConfirmationTask)) 
			will: [:arg | task := arg. #result]].
		
		task message should be: #message
	] runWithMocks 
]

{ #category : #tests }
PtyUserTest >> testGoToBack [
	
	[:navigator | 
		[user goToBack]  
			should strictly satisfy: 
		[guide taskNavigator willReturn: navigator; useArbitrarily.
		navigator forgetCurrentRequest.
		guide retryLastTask]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTest >> testGoToStart [
	
	[:navigator | 
		[user goToStart]  
			should strictly satisfy: 
		[guide taskNavigator willReturn: navigator; useArbitrarily.
		navigator forgetAllButFirst.
		guide retryLastTask]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTest >> testLookAtBlockOrPresenter [
	
	[:blockOrPresenter | 
		[(user lookAt: blockOrPresenter) should be: #result]  
			should strictly satisfy: 
		[blockOrPresenter asUserRequestTask willReturn: #task.
		(guide requestUserFor: #task) willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTest >> testLookAtPresenterWithSomeUIAction [
	
	| task |
	[
		[(user lookAt: #presenter and: #uiActionBlock) should be: #result]  
			should strictly satisfy: 
		[(guide requestUserFor: (Instance of: PtyUserRequestTask)) 
			will: [:arg | task := arg. #result]].
		
		task presenter should be: #presenter.
		task action should be: #uiActionBlock
	] runWithMocks 
]

{ #category : #tests }
PtyUserTest >> testLookAtViewArea [
	
	[:blockOrPresenter | 
		[user lookAtViewArea should be: #result]  
			should strictly satisfy: 
		[(guide requestUserFor: (Instance of: PtyUserRequestTask)) willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTest >> testStoppingCurrentTask [
	
	[:navigator :context | 
		[user stopCurrentTask]  
			should strictly satisfy: 
		[guide taskNavigator willReturn: navigator; useArbitrarily.
		guide context willReturn: context.
		context task willReturn: #currentTask.
		navigator forgetTask: #currentTask.
		guide retryLastTask]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTest >> testTaskExecution [

	| result plannedTask |

	plannedTask := Mock new.
	(workplace stub planExecutionOf: #task by: user) willReturn: plannedTask.
	
	result := user executeTask: #task.
	
	result should beReturnedFrom: [plannedTask requestExecution]
]

{ #category : #'as yet unclassified' }
PtyUserTest >> testWaitingNamedActionExecution [
	
	| task |
	[
		[user wait: #actionName while: #block]  
			should strictly satisfy: 
		[(guide requestUserFor: (Instance of: PtyBlockExecutionTask)) 
			will: [:arg | task := arg]
		].
		
		task block should be: #block.
		task name should be: #actionName
	] runWithMocks 
]

{ #category : #'as yet unclassified' }
PtyUserTest >> testWaitingWhileBlockExecuted [
	
	| task |
	[
		[user waitWhile: #block]  
			should strictly satisfy: 
		[(guide requestUserFor: (Instance of: PtyBlockExecutionTask)) 
			will: [:arg | task := arg]
		].
		
		task block should be: #block
	] runWithMocks 
]

{ #category : #'as yet unclassified' }
PtyUserTest >> testWarning [ 
	
	| task |
	[
		[user warn: #message]  
			should strictly satisfy: 
		[(guide requestUserFor: (Instance of: PtyShowWarningTask)) 
			will: [:arg | task := arg]
		].
		
		task message should be: #message
	] runWithMocks 
]
