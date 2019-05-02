Class {
	#name : #PtyInitiateNewExecutionPlan,
	#superclass : #PtyTaskExecutionPlan,
	#category : #'Presenty-NewCore'
}

{ #category : #running }
PtyInitiateNewExecutionPlan >> run [
	worker runTask: task
]
