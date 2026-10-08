Class {
	#name : #PtyWorker,
	#superclass : #Object,
	#instVars : [
		'workplace',
		'process',
		'activeTask',
		'activeWorkflowStage'
	],
	#category : #'Presenty-Tasks'
}

{ #category : #'instance creation' }
PtyWorker class >> inWorkplace: aWorkplace [

	^self new 
		workplace: aWorkplace
]

{ #category : #accessing }
PtyWorker >> activeTask [
	^ activeWorkflowStage ifNotNil: [ activeWorkflowStage task ]
]

{ #category : #accessing }
PtyWorker >> activeWorkflow [
	^ activeWorkflowStage workflow
]

{ #category : #accessing }
PtyWorker >> activeWorkflowStage [
	^ activeWorkflowStage
]

{ #category : #accessing }
PtyWorker >> activeWorkflowStage: anObject [
	activeWorkflowStage := anObject
]

{ #category : #controlling }
PtyWorker >> continueWorkflowIntoStage: aWorkflowStage [
	
	| result previousStage |
	previousStage := activeWorkflowStage.
	activeWorkflowStage := aWorkflowStage.
	activeWorkflowStage prepareWorkflow.
	result := activeWorkflowStage continueWorkflow.
	activeWorkflowStage := previousStage.
	^result
]

{ #category : #accessing }
PtyWorker >> defaultTaskExecutionPriority [
	^workplace defaultTaskExecutionPriority
]

{ #category : #controlling }
PtyWorker >> executeWorkflowStage: aWorkflowStage [
	
	self isActive ifTrue: [ ^self continueWorkflowIntoStage: aWorkflowStage ].
	"Here it is the case where the system initiates aWorkflowStage from the outside of Presenty context. For example when new task is requested from the playground Presenty will start new worker process"
	self startWorkSessionFor: aWorkflowStage.
	^self isAnotherWorkerActive 
		ifTrue: [ PtyUserRequest signal ]
		ifFalse: [ PtyTaskExecutionFutureResult of: aWorkflowStage task ].
		
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
PtyWorker >> runWorkSessionFor: aWorkflowStage [

	[	aWorkflowStage startNewSession.
		[ self continueWorkflowIntoStage: aWorkflowStage ] 
			on: Error do: [:err | self notifyUserAbout: err]
	] on: PtyUserRequest do: [:request | ].
	
	workplace endWorkSessionFor: aWorkflowStage workflow
]

{ #category : #testing }
PtyWorker >> servesWorkflow: aWorkflow [
	^activeWorkflowStage notNil and: [ activeWorkflowStage workflow = aWorkflow ]
]

{ #category : #accessing }
PtyWorker >> settings [ 
	^workplace settings
]

{ #category : #controlling }
PtyWorker >> startWorkSessionFor: aWorkflowStage [
	
	process := [ self runWorkSessionFor: aWorkflowStage ] newProcess.
	process name: 'WorkSession for ', aWorkflowStage printString.
	process priority: aWorkflowStage executionPriority.
	process resume
]

{ #category : #controlling }
PtyWorker >> stopWorkSession [
	process ifNotNil: [process terminate]
]

{ #category : #accessing }
PtyWorker >> workplace [
	^ workplace
]

{ #category : #accessing }
PtyWorker >> workplace: anObject [
	workplace := anObject
]
