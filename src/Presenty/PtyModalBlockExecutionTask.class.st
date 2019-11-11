Class {
	#name : #PtyModalBlockExecutionTask,
	#superclass : #PtyBlockExecutionTask,
	#category : #'Presenty-BlockExecutionTasks'
}

{ #category : #execution }
PtyModalBlockExecutionTask >> body [

	| warning |
	workplace addCancelAction.
	
	warning := PtyPresentersDecorator named: 'WaitingWarning'.
	
	user lookAt: warning and: [
		workplace executeTask: (PtyReturnValueFromPresenterTask from: warning)].

	block value
]

{ #category : #accessing }
PtyModalBlockExecutionTask >> defaultActivationStrategy [ 

	^PtySeparatedTaskActivationStrategy new
		areaActivator: PtyModalAreaActivator new
]
