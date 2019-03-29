Class {
	#name : #PtyRealInteractionScenariosTest,
	#superclass : #PtyWorkspaceTestCase,
	#instVars : [
		'worker'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyRealInteractionScenariosTest >> setUp [
	super setUp.
	
	worker := PtyWorker at: workspace.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testAddDeferredTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beDeferred.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }.
	result should be: nil
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testAddImmediateTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	
	workspace activeTasks should equal: { task }.
	result should be: #done
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testAddOneShotTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beOneShot.
	
	workspace addTask: task.
	
	workspace activeTasks should be isEmpty.
	result should be: #done
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testExecutionDeferredTaskFromWorkspace [ 

	| task result |
	task := [ result := #done ] asTask.
	task beDeferred.
	workspace addTask: task.
	 
	workspace resumeExecutionOf: task.
	result should be: #done
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testForkTask [ 
	| task result requestedTask forkedTask executions |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred.
	forkedTask := [ result := worker requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	executions := 0.
	task := [ worker addTask: forkedTask. worker := executions + 1 ] asTask.
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
PtyRealInteractionScenariosTest >> testForkTaskWithModalRequestFromAnotherForkedTask [
	| task result requestedTask forkedTask forkedTask2 |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	forkedTask := [ result := worker requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	forkedTask2 := [ worker addTask: forkedTask ] asTask.
	forkedTask2 beForked.
	task := [ worker addTask: forkedTask2 ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	result should be: nil.
	workspace activeTasks should equal: { task. forkedTask2. requestedTask }.
	
	workspace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	workspace activeTasks should equal: { task. forkedTask2. forkedTask }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testForkTaskWithModalUserRequest [
	| task result requestedTask forkedTask executions |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	forkedTask := [ result := worker requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	executions := 0.
	task := [ worker addTask: forkedTask. executions := executions + 1 ] asTask.
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
PtyRealInteractionScenariosTest >> testForkTwoTasksWithModalRequests [
	| task result requestedTask forkedTask done requestedTask2 result2 forkedTask2 |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	forkedTask := [ result := worker requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	requestedTask2 := [ #requestedResult2 ] asTask.
	requestedTask2 beDeferred beModal.
	forkedTask2 := [ result2 := worker requestUserFor: requestedTask2 ] asTask.
	forkedTask2 beForked.
	
	task := [ worker addTask: forkedTask; addTask: forkedTask2. done := true ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	done should be: true.
	result should be: nil.
	result2 should be: nil.
	workspace activeTasks should equal: { task. requestedTask. requestedTask2 }.
	
	workspace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	workspace activeTasks should equal: { task. forkedTask. requestedTask2 }.
	
	workspace resumeExecutionOf: requestedTask2.
	result2 should be: #requestedResult2.
	workspace activeTasks should equal: { task. forkedTask. forkedTask2 }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testRequestUserForDeferredTask [ 
	| task result requestedTask done |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred.
	task := [ result := worker requestUserFor: requestedTask. done := true ] asTask.
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
PtyRealInteractionScenariosTest >> testRequestUserForImmediateTask [ 
	| task result requestedTask done requestedResult |
	requestedResult := #requestedResult.
	requestedTask := [ requestedResult ] asTask.
	requestedTask beImmediate.
	task := [ result := worker requestUserFor: requestedTask. done := true ] asTask.
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
PtyRealInteractionScenariosTest >> testRequestUserForModalTask [ 
	| task result requestedTask done |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	task := [ result := worker requestUserFor: requestedTask. done := true ] asTask.
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
PtyRealInteractionScenariosTest >> testRequestUserForModalTaskFromAnotherImmediateTask [ 
	| task result requestedTask childTask executions |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	childTask := [ result := worker requestUserFor: requestedTask ] asTask.
	childTask beImmediate.
	executions := 0.
	task := [ worker addTask: childTask. executions := executions + 1 ] asTask.
	task beImmediate.
	
	workspace addTask: task.
	result should be: nil.
	executions should be: 0.
	workspace activeTasks should equal: { requestedTask }.
	
	workspace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	executions should be: 1.
	workspace activeTasks should equal: { task. childTask }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testRequestUserForOneShotTask [ 
	| task result requestedTask done requestedResult |
	requestedResult := #requestedResult.
	requestedTask := [ requestedResult ] asTask.
	requestedTask beOneShot.
	task := [ result := worker requestUserFor: requestedTask. done := true ] asTask.
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
