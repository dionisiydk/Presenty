Class {
	#name : #PtyTaskStartStage,
	#superclass : #PtyTaskExecutionStage,
	#category : #'Presenty-NewCore'
}

{ #category : #controlling }
PtyTaskStartStage >> continueExecution [
	^task startExecution
]
