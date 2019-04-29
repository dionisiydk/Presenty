Class {
	#name : #PtyInitiateNewExecutionPlanTest,
	#superclass : #PtyTaskExecutionPlanTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #tests }
PtyInitiateNewExecutionPlanTest >> testRunning [ 
	
	| worker plan |
	worker := Mock new.
	plan := PtyInitiateNewExecutionPlan of: #task by: worker.
	
	plan run.
	
	worker should receive runTask: #task
]
