Class {
	#name : #PtyTaskWorkflowActivationStrategyTestCase,
	#superclass : #PtyTaskLifeCycleStrategyTestCase,
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #testing }
PtyTaskWorkflowActivationStrategyTestCase class >> isAbstract [ 
	^self = PtyTaskWorkflowActivationStrategyTestCase 
]

{ #category : #tests }
PtyTaskWorkflowActivationStrategyTestCase >> testShouldRegisterTaskItselfInExecutionWorkflow [
	
	strategy prepareWorkflow: workflow forExecutionOf: #task.
	
	workflow should receive registerNewTask: #task
]
