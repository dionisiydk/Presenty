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
PtyOneShotTaskReturnStrategyTest >> testShouldActivateInitialWorkflow [ 

	strategy prepareWorkflow: workflow forReturnFrom: task.
	
	task should receive activateInitialWorkflow
]
