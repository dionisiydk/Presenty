Class {
	#name : #PtyModalBlockExecutionTask,
	#superclass : #PtyBlockExecutionTask,
	#category : #'Presenty-BlockExecutionTasks'
}

{ #category : #execution }
PtyModalBlockExecutionTask >> body [

	| warning |
	guide addCancelAction.
	
	warning := PtyPresentersDecorator named: 'WaitingWarning'.
	
	user lookAt: warning and: [
		guide executeTask: (PtyReturnValueFromPresenterTask from: warning)].

	block value
]

{ #category : #accessing }
PtyModalBlockExecutionTask >> defaultActivationStrategy [ 

	^PtySeparatedTaskActivationStrategy new
		areaActivator: PtyModalAreaActivator new
]
