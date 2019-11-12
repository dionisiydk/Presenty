Class {
	#name : #PtyRetryTaskTest,
	#superclass : #TestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyRetryTaskTest >> testExecution [

	| targetTask task |
	targetTask := Mock new.
	task := PtyRetryTask for: targetTask.
	
	task body.
	
	targetTask should receive jumpToRetryStage
]

{ #category : #tests }
PtyRetryTaskTest >> testHasSamePriorityAsCompleteTask [

	| task targetTask |
	targetTask := Mock new.	
	task := PtyRetryTask for: targetTask.
	
	task executionPriority should beReturnedFrom: [ targetTask executionPriority ]
]
