Extension { #name : #PtyUserTests }

{ #category : #'*PresentyTests-NotificationTasks' }
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

{ #category : #'*PresentyTests-BlockExecutionTasks' }
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

{ #category : #'*PresentyTests-BlockExecutionTasks' }
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

{ #category : #'*PresentyTests-NotificationTasks' }
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
