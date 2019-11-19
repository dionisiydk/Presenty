Class {
	#name : #PtyTaskReturnStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #'Presenty-NewCore'
}

{ #category : #'task execution' }
PtyTaskReturnStrategy >> prepareWorkflow: aWorkflow forReturnFrom: aTask [
	
	self subclassResponsibility 
]
