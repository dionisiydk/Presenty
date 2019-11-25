Class {
	#name : #PtyOneShotTaskAcceptenceTest,
	#superclass : #PtyTaskExecutionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyOneShotTaskAcceptenceTest >> testExecutionAsChildTask [ 

	| task |
	task := [ ] asTask beOneShot.
	
	user executeTask: [user executeTask: task.
		workplace currentTasks should not include: task] asTask.
	
	workplace currentTasks should not include: task
]

{ #category : #tests }
PtyOneShotTaskAcceptenceTest >> testExecutionAsFirstTask [ 

	| task |
	task := [ ] asTask beOneShot.
	
	user executeTask: task.
	
	workplace currentTasks should be isEmpty
]

{ #category : #tests }
PtyOneShotTaskAcceptenceTest >> testExecutionWithOwnChildTask [

	| task childTask |
	childTask := [ ] asTask bePermanent.
	task := [ user executeTask: childTask.
		workplace currentTasks should include: childTask ] asTask beOneShot.
	
	user executeTask: task.
	
	workplace currentTasks should not include: task.
	workplace currentTasks should not include: childTask.
]
