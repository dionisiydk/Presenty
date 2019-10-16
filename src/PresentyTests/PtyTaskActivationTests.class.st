Class {
	#name : #PtyTaskActivationTests,
	#superclass : #TestCase,
	#instVars : [
		'guide'
	],
	#category : #'PresentyTests-Acceptance'
}

{ #category : #running }
PtyTaskActivationTests >> setUp [
	super setUp.
	
	guide := PtyGuide new.
	(guide uiSettings stub appropriateTaskLike: Any inContextOf: Any)
		will: [ :task :context | task ]
]

{ #category : #tests }
PtyTaskActivationTests >> testEmbeddedChildTaskCall [

	| childTask ownerTask |
	childTask := [ PtyUserRequest signal ] asTask.
	ownerTask := [ guide requestUserFor: childTask  ] asTask.
	childTask activationStrategy: PtyEmbeddedTaskActivationStrategy new.
	
	[guide requestUserFor: ownerTask] should raise: PtyUserRequest.
	
	guide currentTasks should haveSize: 2.
	guide currentTasks first task should be: ownerTask.
	guide currentTasks last task should be: childTask.
]

{ #category : #tests }
PtyTaskActivationTests >> testReturnFromEmbeddedTask [

	| task result |
	task := [ #result ] asTask.
	task activationStrategy: PtyEmbeddedTaskActivationStrategy new.
	
	result := guide requestUserFor: task.
	
	result should be: #result.
	guide currentTasks should haveSize: 1.
	guide currentTasks first task should be: task
]

{ #category : #tests }
PtyTaskActivationTests >> testReturnFromSeparatedTask [

	| task result |
	task := [ #result ] asTask.
	task activationStrategy: PtySeparatedTaskActivationStrategy new.
	
	result := guide requestUserFor: task.
	
	result should be: #result.
	guide currentTasks should be isEmpty
]

{ #category : #tests }
PtyTaskActivationTests >> testSeparatedChildTaskCall [

	| childTask ownerTask |
	childTask := [ PtyUserRequest signal ] asTask.
	ownerTask := [ guide requestUserFor: childTask  ] asTask.
	childTask activationStrategy: PtySeparatedTaskActivationStrategy new.
	
	[guide requestUserFor: ownerTask] should raise: PtyUserRequest.
	
	guide currentTasks should haveSize: 1.
	guide currentTasks last task should be: childTask.
]

{ #category : #tests }
PtyTaskActivationTests >> testSingleTaskCall [

	| task |
	task := [ PtyUserRequest signal ] asTask.
	
	[guide requestUserFor: task] should raise: PtyUserRequest.
	
	guide currentTasks should haveSize: 1.
	guide currentTasks first task should be: task
]
