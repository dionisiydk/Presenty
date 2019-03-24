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
PtyInteractionScenariosTest >> testAddDeferredTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beDeferred.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }.
	result should be: nil
]

{ #category : #tests }
PtyInteractionScenariosTest >> testAddImmediateTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }.
	result should be: #done
]

{ #category : #tests }
PtyInteractionScenariosTest >> testAddOneShotTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beOneShot.
	
	workspace addTask: task.
	
	workspace activeTasks should be isEmpty.
	result should be: #done
]

{ #category : #tests }
PtyInteractionScenariosTest >> testExecutionDeferredTaskFromWorkspace [ 

	| task result |
	task := [ result := #done ] asTask.
	task beDeferred.
	workspace addTask: task.
	 
	workspace resumeExecutionOf: task.
	result should be: #done
]

{ #category : #tests }
PtyInteractionScenariosTest >> testForkTask [ 
	| task result requestedTask forkedTask executions |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred.
	forkedTask := [ result := workspace requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	executions := 0.
	task := [ workspace addTask: forkedTask. executions := executions + 1 ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	result should be: nil.
	executions should be: 1.
	workspace activeTasks should equal: { task. forkedTask. requestedTask }.
	
	workspace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	executions should be: 1.
	workspace activeTasks should equal: { task. forkedTask. requestedTask }.
]

{ #category : #tests }
PtyInteractionScenariosTest >> testForkTaskWithModalUserRequest [
	| task result requestedTask forkedTask executions |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	forkedTask := [ result := workspace requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	executions := 0.
	task := [ workspace addTask: forkedTask. executions := executions + 1 ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	result should be: nil.
	executions should be: 1.
	workspace activeTasks should equal: { task. requestedTask }.
	
	workspace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	executions should be: 1.
	workspace activeTasks should equal: { task. forkedTask }.
]

{ #category : #tests }
PtyInteractionScenariosTest >> testRequestUserForDeferredTask [ 
	| task result requestedTask done |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred.
	task := [ result := workspace requestUserFor: requestedTask. done := true ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	result should be: nil.
	done should not be: true.
	workspace activeTasks should equal: { task. requestedTask }.
	
	workspace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	done should be: true.
	
	workspace resumeExecutionOf: task with: #newResult.
	result should be: #newResult
]

{ #category : #tests }
PtyInteractionScenariosTest >> testRequestUserForImmediateTask [ 
	| task result requestedTask done requestedResult |
	requestedResult := #requestedResult.
	requestedTask := [ requestedResult ] asTask.
	requestedTask beImmediate.
	task := [ result := workspace requestUserFor: requestedTask. done := true ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	result should be: requestedResult.
	done should be: true.
	workspace activeTasks should equal: { task. requestedTask }.
	
	requestedResult := #newResult1.
	workspace resumeExecutionOf: requestedResult.
	result should be: requestedResult.
	
	workspace resumeExecutionOf: task with: #newResult2.
	result should be: #newResult2
]

{ #category : #tests }
PtyInteractionScenariosTest >> testRequestUserForModalTask [ 
	| task result requestedTask done |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	task := [ result := workspace requestUserFor: requestedTask. done := true ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	result should be: nil.
	done should not be: true.
	workspace activeTasks should equal: { requestedTask }.
	
	workspace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	done should be: true.
	workspace activeTasks should equal: { task }.
]

{ #category : #tests }
PtyInteractionScenariosTest >> testRequestUserForOneShotTask [ 
	| task result requestedTask done requestedResult |
	requestedResult := #requestedResult.
	requestedTask := [ requestedResult ] asTask.
	requestedTask beOneShot.
	task := [ result := workspace requestUserFor: requestedTask. done := true ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	result should be: requestedResult.
	done should be: true.
	workspace activeTasks should equal: { task }.
	
	requestedResult := #newResult1.
	[workspace resumeExecutionOf: requestedTask] should fail.
	result should be: #requestedResult.
	workspace activeTasks should equal: { task }.
	
	workspace resumeExecutionOf: task with: #newResult2.
	result should be: #newResult2
]
