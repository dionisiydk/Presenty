Class {
	#name : #PtyTaskExecutionPlan,
	#superclass : #Object,
	#instVars : [
		'task',
		'worker'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyTaskExecutionPlan class >> of: aTask by: aWorker [
	^self new 
		task: aTask;
		worker: aWorker
]

{ #category : #running }
PtyTaskExecutionPlan >> run [ 
	self subclassResponsibility 
]

{ #category : #accessing }
PtyTaskExecutionPlan >> task [
	^ task
]

{ #category : #accessing }
PtyTaskExecutionPlan >> task: anObject [
	task := anObject
]

{ #category : #accessing }
PtyTaskExecutionPlan >> worker [
	^ worker
]

{ #category : #accessing }
PtyTaskExecutionPlan >> worker: anObject [
	worker := anObject
]
