Class {
	#name : #PtyOneShotTaskReturnStrategyTest,
	#superclass : #PtyTaskReturnStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyOneShotTaskReturnStrategyTest >> createStrategy [
	^PtyOneShotTaskReturnStrategy new
]

{ #category : #tests }
PtyOneShotTaskReturnStrategyTest >> testShouldRemoveFromWorkflowTheTaskWhichReturnsResult [ 

	strategy prepareWorkflow: workflow forReturnFrom: task.
	
	workflow should receive removeTask: task
]
