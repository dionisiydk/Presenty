Class {
	#name : #PtyInteractionScenariosTest,
	#superclass : #TestCase,
	#instVars : [
		'workspace'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyInteractionScenariosTest >> setUp [
	super setUp.
	
	workspace := PtyWorkspace new.
]

{ #category : #tests }
PtyInteractionScenariosTest >> testExecutionDeferredTaskFromWorkspace [ 

	| task result |
	task := [ result := #done ] asTask.
	task executionStrategy: PtyDeferredTaskExecution new.
	workspace addTask: task.
	 
	workspace activeTasks last resumeExecution.	 
	result should be: #done
]

{ #category : #tests }
PtyInteractionScenariosTest >> testSingleDeferredTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task executionStrategy: PtyDeferredTaskExecution new.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }.
	result should be: nil
]

{ #category : #tests }
PtyInteractionScenariosTest >> testSingleImmediateTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task executionStrategy: PtyImmediateTaskExecution new.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }.
	result should be: #done
]

{ #category : #tests }
PtyInteractionScenariosTest >> testSingleOneShotTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task executionStrategy: PtyOneShotTaskExecution new.
	
	workspace addTask: task.
	
	workspace activeTasks should be isEmpty.
	result should be: #done
]
