Class {
	#name : #PtyTaskReturnStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #'Presenty-Tasks'
}

{ #category : #'task execution' }
PtyTaskReturnStrategy >> prepareReturnFrom: aTask [
	
	self subclassResponsibility 
]
