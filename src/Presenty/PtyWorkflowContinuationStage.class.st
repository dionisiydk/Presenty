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

	task jumpToWorkflowStage: self
]

{ #category : #execution }
PtyWorkflowContinuationStage >> startInInactiveWorkflowBy: aWorker [
	
	aWorker startWorkflowWithTask: (PtyContinueWorkflowTask for: task with: self).
	
	^ PtyTaskExecutionFutureResult of: task
]
