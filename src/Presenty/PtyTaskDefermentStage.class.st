Class {
	#name : #PtyTaskDefermentStage,
	#superclass : #PtyWorkflowStage,
	#category : #Presenty
}

{ #category : #controlling }
PtyTaskDefermentStage >> continueWorkflow [
	
	^PtyUserRequest signal
	
]

{ #category : #execution }
PtyTaskDefermentStage >> startInActiveWorkflowBy: aWorker [
	"When task needs to be deferred from the currently running workflow
	it still needs to be passed to the worker to correctly initialize the deferred execution:
		- task should keep a continuation to be able to be executed later and continue current workflow
	The actual defer logic (the stop of execution) is performed by execution strategy"
	
	^aWorker continueWorkflowWithTask: task usingStartStage: self
]

{ #category : #execution }
PtyTaskDefermentStage >> startInInactiveWorkflowBy: aWorker [
	"Deferred task does not run immediately. 
	So we do nothing when it is requested from the out of workflow"
]
