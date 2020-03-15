Class {
	#name : #PtyWorker,
	#superclass : #Object,
	#instVars : [
		'workplace',
		'process',
		'activeTask'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyWorker class >> inWorkplace: aWorkplace [

	^self new 
		workplace: aWorkplace
]

{ #category : #accessing }
PtyWorker >> activeTask [
	^ activeTask
]

{ #category : #accessing }
PtyWorker >> activeTask: aTask [
	activeTask := aTask
]

{ #category : #controlling }
PtyWorker >> continueWorkflowWithTask: aTask usingStartStage: aTaskStartStage [
	
	| executionStage result |
	executionStage := aTask currentWorkflowStageStartedWith: aTaskStartStage.	
	
	activeTask := aTask.
	result := executionStage continueWorkflow.
	activeTask := aTask parentTask.
	
	^result
]

{ #category : #accessing }
PtyWorker >> defaultTaskExecutionPriority [
	^workplace defaultTaskExecutionPriority
]

{ #category : #controlling }
PtyWorker >> executeWorkflowStage: aWorkflowStage [
	
	| futureResult |
	self isActive ifTrue: [ ^aWorkflowStage startInActiveWorkflowBy: self].
	
	futureResult := aWorkflowStage startInInactiveWorkflowBy: self.
	^self isAnotherWorkerActive 
		ifTrue: [ PtyUserRequest signal ]
		ifFalse: [ futureResult ]
]

{ #category : #testing }
PtyWorker >> isActive [ 
	^process == Processor activeProcess
]

{ #category : #testing }
PtyWorker >> isAnotherWorkerActive [
	| activeWorkflow |

	activeWorkflow := workplace findActiveWorkflowIfNone: [ ^false ].
	
	^activeWorkflow worker ~= self
]

{ #category : #'task execution' }
PtyWorker >> notifyUserAbout: anError [

	^anError pass
]

{ #category : #accessing }
PtyWorker >> process [
	^ process
]

{ #category : #accessing }
PtyWorker >> process: anObject [
	process := anObject
]

{ #category : #controlling }
PtyWorker >> runInitialTask: aTask usingStartStage: aTaskStartStage [

	[	
		[self continueWorkflowWithTask: aTask usingStartStage: aTaskStartStage] 
			on: Error do: [:err | self notifyUserAbout: err]

	] on: PtyUserRequest do: [:request | 
			request executeBy: self].
	
	self waitUserAction
]

{ #category : #testing }
PtyWorker >> servesWorkflow: aWorkflow [
	^activeTask notNil and: [activeTask workflow = aWorkflow]
]

{ #category : #controlling }
PtyWorker >> startWorkflowWithTask: aTask [
	self startWorkflowWithTask: aTask usingStartStage: (PtyTaskStartStage for: aTask)
]

{ #category : #controlling }
PtyWorker >> startWorkflowWithTask: aTask usingStartStage: aTaskStartStage [
	
	process := [ self runInitialTask: aTask usingStartStage: aTaskStartStage ] newProcess.
	process name: 'Worker process of ', aTask printString.
	process priority: aTask executionPriority.
	process resume
]

{ #category : #controlling }
PtyWorker >> stopWorkflow [
	process ifNotNil: [process terminate]
]

{ #category : #'task execution' }
PtyWorker >> waitUserAction [
]

{ #category : #accessing }
PtyWorker >> workplace [
	^ workplace
]

{ #category : #accessing }
PtyWorker >> workplace: anObject [
	workplace := anObject
]
