Class {
	#name : #PtyModalBlockExecutionTask,
	#superclass : #PtyBlockExecutionTask,
	#category : #'Presenty-BlockExecutionTasks'
}

{ #category : #execution }
PtyModalBlockExecutionTask >> body [

	| warning |
	worker addCancelAction.
	
	warning := PtyPresentersDecorator named: 'WaitingWarning'.
	
	user lookAt: warning and: [
		worker executeTask: (PtyReturnValueFromPresenterTask from: warning)].

	block value
]

{ #category : #accessing }
PtyModalBlockExecutionTask >> defaultActivationStrategy [ 

	^PtySeparatedTaskActivationStrategy new
		areaActivator: PtyModalAreaActivator new
]
