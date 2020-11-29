Class {
	#name : #PtyOneShotTaskReturnStrategyTest,
	#superclass : #PtyTaskReturnStrategyTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #running }
PtyOneShotTaskReturnStrategyTest >> createStrategy [
	^PtyOneShotTaskReturnStrategy new
]

{ #category : #tests }
PtyOneShotTaskReturnStrategyTest >> testShouldResumeInitialWorkflow [ 

	strategy prepareReturnFrom: task.
	
	task should receive resumeInitialWorkflow
]
