Class {
	#name : #PtyPermanentTaskReturnStrategyTest,
	#superclass : #PtyTaskReturnStrategyTestCase,
	#category : #'Presenty-Tests'
}

{ #category : #running }
PtyPermanentTaskReturnStrategyTest >> createStrategy [
	^PtyPermanentTaskReturnStrategy new
]

{ #category : #tests }
PtyPermanentTaskReturnStrategyTest >> testShouldDoNothingWithWorkflowOnTaskReturn [

	strategy prepareWorkflow: workflow forReturnFrom: task.
	
	workflow should not receive anyMessage
]