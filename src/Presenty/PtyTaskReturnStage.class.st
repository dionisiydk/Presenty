Class {
	#name : #PtyTaskReturnStage,
	#superclass : #PtyTaskExecutionStage,
	#instVars : [
		'result'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #accessing }
PtyTaskReturnStage class >> of: aTask withResult: anObject [
	^(self of: aTask)
		result: anObject
]

{ #category : #controlling }
PtyTaskReturnStage >> continueExecution [
	^result
]

{ #category : #accessing }
PtyTaskReturnStage >> result: anObject [
	result := anObject
]
