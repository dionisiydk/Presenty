Class {
	#name : #PtyTaskReturnStrategy,
	#superclass : #PtyTaskLifeCycleStrategy,
	#category : #Presenty
}

{ #category : #'task execution' }
PtyTaskReturnStrategy >> prepareReturnFrom: aTask [
	
	self subclassResponsibility 
]
