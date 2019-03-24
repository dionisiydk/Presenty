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
PtyInteractionScenariosTest >> testSingleDeferredTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task activationStrategy: PtyDeferredTaskActivationStrategy new.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }.
	result should be: nil
]

{ #category : #tests }
PtyInteractionScenariosTest >> testSingleImmediateTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task activationStrategy: PtyImmediateTaskActivationStrategy new.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }.
	result should be: #done
]

{ #category : #tests }
PtyInteractionScenariosTest >> testSingleOneShotTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task activationStrategy: PtyOneShotTaskActivationStrategy new.
	
	workspace addTask: task.
	
	workspace activeTasks should be isEmpty.
	result should be: #done
]
