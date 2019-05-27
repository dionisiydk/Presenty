Class {
	#name : #PtyDeliverResultTaskTest,
	#superclass : #TestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyDeliverResultTaskTest >> testExecution [

	| completeTask deliverTask |
	completeTask := Mock new.
	deliverTask := PtyDeliverResultTask result: #taskResult from: completeTask.
	
	deliverTask body.
	
	completeTask should receive completeExecutionWith: #taskResult
]

{ #category : #tests }
PtyDeliverResultTaskTest >> testHasSamePriorityAsCompleteTask [

	| task completeTask |
	completeTask := Mock new.
	task := PtyDeliverResultTask result: #taskResult from: completeTask.
	
	task executionPriority should beReturnedFrom: [ completeTask executionPriority ]
]
