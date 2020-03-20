Class {
	#name : #PtyTaskReturnStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyTaskReturnStrategy >> prepareWorkflow: aWorkflow forReturnFrom: aTask [
	
	self subclassResponsibility 
]
