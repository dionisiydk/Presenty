Class {
	#name : #PtyWorkflowContinuationStage,
	#superclass : #PtyWorkflowStage,
	#category : #'Presenty-NewCore'
}

{ #category : #testing }
PtyWorkflowContinuationStage class >> isAbstract [ 
	^self = PtyWorkflowContinuationStage 
]

{ #category : #execution }
PtyWorkflowContinuationStage >> startInActiveWorkflowBy: aWorker [

	^task jumpToExecutionStage: self
]

{ #category : #execution }
PtyWorkflowContinuationStage >> startInInactiveWorkflowBy: aWorker [
	
	aWorker startWithTask: (PtyContinueWorkflowTask for: task with: self).
	
	^ PtyTaskExecutionFutureResult of: task
]
