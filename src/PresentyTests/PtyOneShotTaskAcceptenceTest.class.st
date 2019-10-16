Class {
	#name : #PtyOneShotTaskAcceptenceTest,
	#superclass : #PtyRealInteractionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyOneShotTaskAcceptenceTest >> testExecutingAsChildTask [ 

	| task result |
	task := [
		workplace currentTasks should include: task.
		result := #done ] asTask.
	task beOneShot.
	
	user executeTask: [result := user executeTask: task] asTask.
	
	workplace currentTasks should not include: task.
	result should be: #done
]

{ #category : #tests }
PtyOneShotTaskAcceptenceTest >> testExecutingAsFirstTask [ 

	| task result |
	task := [
		workplace currentTasks should include: task.
		result := #done ] asTask.
	task beOneShot.
	
	user executeTask: task.
	
	workplace currentTasks should be isEmpty.
	result should be: #done
]
