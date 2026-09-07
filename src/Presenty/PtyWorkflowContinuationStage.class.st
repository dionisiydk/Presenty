Class {
	#name : #PtyWorkflowContinuationStage,
	#superclass : #PtyWorkflowStage,
	#category : #'Presenty-Tasks'
}

{ #category : #testing }
PtyWorkflowContinuationStage class >> isAbstract [ 
	^self = PtyWorkflowContinuationStage 
]

{ #category : #execution }
PtyWorkflowContinuationStage >> startInActiveWorkflowBy: aWorker [

	task jumpToWorkflowStage: self
]
