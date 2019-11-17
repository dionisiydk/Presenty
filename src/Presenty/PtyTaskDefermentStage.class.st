Class {
	#name : #PtyTaskDefermentStage,
	#superclass : #PtyTaskExecutionStage,
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyTaskDefermentStage >> continueExecution [
	^task startExecution
]
