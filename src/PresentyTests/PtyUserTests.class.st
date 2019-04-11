Class {
	#name : #PtyUserTests,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'user'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyUserTests >> setUp [
	super setUp.

	workplace := Mock new.
	user := PtyUser of: workplace
]

{ #category : #'as yet unclassified' }
PtyUserTests >> testConfirm [
	
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
PtyUserTests >> testGoToBack [
	
	[:navigator | 
		[user goToBack]  
			should strictly satisfy: 
		[guide taskNavigator willReturn: navigator; useArbitrarily.
		navigator forgetCurrentRequest.
		guide retryLastTask]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTests >> testGoToStart [
	
	[:navigator | 
		[user goToStart]  
			should strictly satisfy: 
		[guide taskNavigator willReturn: navigator; useArbitrarily.
		navigator forgetAllButFirst.
		guide retryLastTask]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTests >> testLookAtBlockOrPresenter [
	
	[:blockOrPresenter | 
		[(user lookAt: blockOrPresenter) should be: #result]  
			should strictly satisfy: 
		[blockOrPresenter asUserRequestTask willReturn: #task.
		(guide requestUserFor: #task) willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTests >> testLookAtPresenterWithSomeUIAction [
	
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
PtyUserTests >> testLookAtViewArea [
	
	[:blockOrPresenter | 
		[user lookAtViewArea should be: #result]  
			should strictly satisfy: 
		[(guide requestUserFor: (Instance of: PtyUserRequestTask)) willReturn: #result]
	] runWithMocks 
]

{ #category : #tests }
PtyUserTests >> testStoppingCurrentTask [
	
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
PtyUserTests >> testTaskExecution [

	| result task |
	task := [] asTask.
	result := user executeTask: task.
	
	result should beReturnedFrom: [workplace processTask: task]
]

{ #category : #tests }
PtyUserTests >> testTaskExecutionShouldSetUpUserForTask [

	| result task |
	task := [] asTask.
	result := user executeTask: task.
	
	task user should be: user
]

{ #category : #'as yet unclassified' }
PtyUserTests >> testWaitingNamedActionExecution [
	
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
PtyUserTests >> testWaitingWhileBlockExecuted [
	
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
PtyUserTests >> testWarning [ 
	
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
