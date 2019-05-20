Class {
	#name : #PtyDeferredTaskAcceptanceTest,
	#superclass : #PtyRealInteractionAcceptanceTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutingAsChildTask [ 

	| task result |
	task := [ #result ] asTask.
	task beDeferred.
	
	user executeTask: [ result := user executeTask: task] asTask.

	result should be: #nil.
	workplace activeTasks should include: task
]

{ #category : #tests }
PtyDeferredTaskAcceptanceTest >> testExecutingAsFirstTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beDeferred.
	
	user executeTask: task.
	
	workplace activeTasks should equal: { task }.
	result should be: nil
]
