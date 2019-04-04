Class {
	#name : #PtyRealInteractionScenariosTest,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'user'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #running }
PtyRealInteractionScenariosTest >> setUp [
	super setUp.
	
	user := PtyUser of: workplace.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testAddDeferredTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beDeferred.
	
	workplace addTask: task.
	
	workplace activeTasks should equal: { task }.
	result should be: nil
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testAddImmediateTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	
	workplace activeTasks should equal: { task }.
	result should be: #done
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testAddOneShotTask [ 

	| task result |
	task := [ result := #done ] asTask.
	task beOneShot.
	
	workplace addTask: task.
	
	workplace activeTasks should be isEmpty.
	result should be: #done
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testExecutionDeferredTaskFromWorkspace [ 

	| task result |
	task := [ result := #done ] asTask.
	task beDeferred.
	workplace addTask: task.
	 
	workplace resumeExecutionOf: task.
	result should be: #done
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testForkTask [ 
	| task result requestedTask forkedTask executions |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred.
	forkedTask := [ result := user requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	executions := 0.
	task := [ user addTask: forkedTask. user := executions + 1 ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	result should be: nil.
	executions should be: 1.
	workplace activeTasks should equal: { task. forkedTask. requestedTask }.
	
	workplace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	executions should be: 1.
	workplace activeTasks should equal: { task. forkedTask. requestedTask }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testForkTaskWithModalRequestFromAnotherForkedTask [
	| task result requestedTask forkedTask forkedTask2 |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	forkedTask := [ result := user requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	forkedTask2 := [ user addTask: forkedTask ] asTask.
	forkedTask2 beForked.
	task := [ user addTask: forkedTask2 ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	result should be: nil.
	workplace activeTasks should equal: { task. forkedTask2. requestedTask }.
	
	workplace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	workplace activeTasks should equal: { task. forkedTask2. forkedTask }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testForkTaskWithModalUserRequest [
	| task result requestedTask forkedTask executions |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	forkedTask := [ result := user requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	executions := 0.
	task := [ user addTask: forkedTask. executions := executions + 1 ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	result should be: nil.
	executions should be: 1.
	workplace activeTasks should equal: { task. requestedTask }.
	
	workplace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	executions should be: 1.
	workplace activeTasks should equal: { task. forkedTask }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testForkTwoTasksWithModalRequests [
	| task result requestedTask forkedTask done requestedTask2 result2 forkedTask2 |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	forkedTask := [ result := user requestUserFor: requestedTask ] asTask.
	forkedTask beForked.
	requestedTask2 := [ #requestedResult2 ] asTask.
	requestedTask2 beDeferred beModal.
	forkedTask2 := [ result2 := user requestUserFor: requestedTask2 ] asTask.
	forkedTask2 beForked.
	
	task := [ user addTask: forkedTask; addTask: forkedTask2. done := true ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	done should be: true.
	result should be: nil.
	result2 should be: nil.
	workplace activeTasks should equal: { task. requestedTask. requestedTask2 }.
	
	workplace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	workplace activeTasks should equal: { task. forkedTask. requestedTask2 }.
	
	workplace resumeExecutionOf: requestedTask2.
	result2 should be: #requestedResult2.
	workplace activeTasks should equal: { task. forkedTask. forkedTask2 }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testRequestUserForDeferredTask [ 
	| task result requestedTask done |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred.
	task := [ result := user requestUserFor: requestedTask. done := true ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	result should be: nil.
	done should not be: true.
	workplace activeTasks should equal: { task. requestedTask }.
	
	workplace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	done should be: true.
	
	workplace resumeExecutionOf: task with: #newResult.
	result should be: #newResult
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testRequestUserForImmediateTask [ 
	| task result requestedTask done requestedResult |
	requestedResult := #requestedResult.
	requestedTask := [ requestedResult ] asTask.
	requestedTask beImmediate.
	task := [ result := user requestUserFor: requestedTask. done := true ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	result should be: requestedResult.
	done should be: true.
	workplace activeTasks should equal: { task. requestedTask }.
	
	requestedResult := #newResult1.
	workplace resumeExecutionOf: requestedResult.
	result should be: requestedResult.
	
	workplace resumeExecutionOf: task with: #newResult2.
	result should be: #newResult2
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testRequestUserForModalTask [ 
	| task result requestedTask done |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	task := [ result := user requestUserFor: requestedTask. done := true ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	result should be: nil.
	done should not be: true.
	workplace activeTasks should equal: { requestedTask }.
	
	workplace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	done should be: true.
	workplace activeTasks should equal: { task }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testRequestUserForModalTaskFromAnotherImmediateTask [ 
	| task result requestedTask childTask executions |
	requestedTask := [ #requestedResult ] asTask.
	requestedTask beDeferred beModal.
	childTask := [ result := user requestUserFor: requestedTask ] asTask.
	childTask beImmediate.
	executions := 0.
	task := [ user addTask: childTask. executions := executions + 1 ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	result should be: nil.
	executions should be: 0.
	workplace activeTasks should equal: { requestedTask }.
	
	workplace resumeExecutionOf: requestedTask.
	result should be: #requestedResult.
	executions should be: 1.
	workplace activeTasks should equal: { task. childTask }.
]

{ #category : #tests }
PtyRealInteractionScenariosTest >> testRequestUserForOneShotTask [ 
	| task result requestedTask done requestedResult |
	requestedResult := #requestedResult.
	requestedTask := [ requestedResult ] asTask.
	requestedTask beOneShot.
	task := [ result := user requestUserFor: requestedTask. done := true ] asTask.
	task beImmediate.
	
	workplace addTask: task.
	result should be: requestedResult.
	done should be: true.
	workplace activeTasks should equal: { task }.
	
	requestedResult := #newResult1.
	[workplace resumeExecutionOf: requestedTask] should fail.
	result should be: #requestedResult.
	workplace activeTasks should equal: { task }.
	
	workplace resumeExecutionOf: task with: #newResult2.
	result should be: #newResult2
]
