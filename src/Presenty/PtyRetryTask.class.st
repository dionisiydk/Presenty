Class {
	#name : #PtyRetryTask,
	#superclass : #PtyExecutionControllingTask,
	#category : #'Presenty-NewCore'
}

{ #category : #execution }
PtyRetryTask >> body [
	executingTask jumpToRetryStage
]
