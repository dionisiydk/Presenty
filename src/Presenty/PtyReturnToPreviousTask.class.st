Class {
	#name : #PtyReturnToPreviousTask,
	#superclass : #PtyUserAction,
	#category : #'Presenty-Core'
}

{ #category : #execution }
PtyReturnToPreviousTask >> execute [ 

	| guide currentTasks |
	guide := presenter guide.
	currentTasks := guide activeTasks copy.
	
	guide executeTask: [
		guide activeTasks: currentTasks.
		guide user goToBack] asTask 
]
