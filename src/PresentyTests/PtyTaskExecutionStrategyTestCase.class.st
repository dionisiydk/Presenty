Class {
	#name : #PtyTaskExecutionStrategyTestCase,
	#superclass : #PtyTaskLifeCycleStrategyTestCase,
	#category : #'PresentyTests-NewCore'
}

{ #category : #testing }
PtyTaskExecutionStrategyTestCase class >> isAbstract [ 
	^self = PtyTaskExecutionStrategyTestCase
]

{ #category : #tests }
PtyTaskExecutionStrategyTestCase >> testShouldRegisterTaskItselfInExecutionWorkflow [
	
	strategy prepareWorkflow: workflow forExecutionOf: #task.
	
	workflow should receive registerNewTask: #task
]
