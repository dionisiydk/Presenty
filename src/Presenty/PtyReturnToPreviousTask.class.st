Class {
	#name : #PtyReturnToPreviousTask,
	#superclass : #PtyUserAction,
	#category : #'Presenty-Core'
}

{ #category : #execution }
PtyReturnToPreviousTask >> execute [ 

	| guide currentTasks |
	guide := presenter guide.
	currentTasks := guide currentTasks copy.
	
	guide executeTask: [
		guide currentTasks: currentTasks.
		guide user goToBack] asTask 
]
