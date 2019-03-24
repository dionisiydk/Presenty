Class {
	#name : #PtyActivateTaskTests,
	#superclass : #PtyUserActionTestCase,
	#instVars : [
		'task'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyActivateTaskTests >> setUp [
	super setUp.
	
	task := Mock new.
	action task: task
]

{ #category : #tests }
PtyActivateTaskTests >> testExecuting [

	[:guide |	
		[action execute]
			should strictly satisfy: 
		[presenter guide willReturn: guide; useArbitrarily.
		presenter context willReturn: #context; useArbitrarily.
		guide setUpContext: #context.
		guide executeTask: task].
			
	] runWithMocks 
]

{ #category : #tests }
PtyActivateTaskTests >> testGettingPrototypeContextName [

	[	
		[action prototypeContextName should be: #result]
			should strictly satisfy: 
		[task prototypeContextName willReturn: #result].
			
	] runWithMocks 
]

{ #category : #running }
PtyActivateTaskTests >> userActionClass [ 
	^PtyActivateTask
]
