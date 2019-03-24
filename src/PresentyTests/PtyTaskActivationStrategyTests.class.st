Class {
	#name : #PtyTaskActivationStrategyTests,
	#superclass : #TestCase,
	#instVars : [
		'guide',
		'activation'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyTaskActivationStrategyTests >> setUp [
	super setUp.
	
	guide := Mock new.	
	activation := PtyTaskActivationStrategy new.
	activation guide: guide.
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testActivationTask [

	| actual |
	[:task :taskContext |
		[actual := activation activateTask: task]
			should strictly satisfy: 
		[(task createContextFor: activation) willReturn: taskContext.
		(guide activateContext: taskContext) willReturn: #result].
	
		actual should be: #result
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testActivationTaskWhenTaskShouldBeForgottenAfterExecution [

	| actual |
	[:task :taskContext |
		activation shouldForgetCompleteTask: true.
		
		[actual := activation activateTask: task]
			should strictly satisfy: 
		[(task createContextFor: activation) willReturn: taskContext.
		(guide activateContext: taskContext) willReturn: #result.
		guide forgetTask: task].
	
		actual should be: #result
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testActivationTaskWhenTaskShouldBeRemembered [

	| actual |
	[:task :taskContext |
		activation shouldRememberTask: true.
		[actual := activation activateTask: task]
			should strictly satisfy: 
		[(task createContextFor: activation) willReturn: taskContext.
		guide rememberTask: taskContext.
		(guide activateContext: taskContext) willReturn: #result].
	
		actual should be: #result
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testAllowSepareteItemsByDefault [

	activation allowSeparateItems should be: true
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testPrepareForEscapeToTaskWhenAllChildrenOfSourceContextShouldNotRestoreParentArea [

	| actual |
	[:task :sourceContext |
		activation shouldRestoreParentArea: #initialState.
		
		[activation prepareForEscapeTo: task fromContext: sourceContext]
			should strictly satisfy: 
		[task allowChangeParentViewAreaState willReturn: true.
		sourceContext shouldRestoreParentArea willReturn: false.
		(sourceContext isCreatedInContextOf: task) willReturn: false.
		sourceContext isChildrenShouldRestoreParentArea willReturn: false].
	
		activation shouldRestoreParentArea should be: false
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testPrepareForEscapeToTaskWhenAllChildrenOfSourceContextShouldRestoreParentArea [

	| actual |
	[:task :sourceContext |
		activation shouldRestoreParentArea: #initialState.
		
		[activation prepareForEscapeTo: task fromContext: sourceContext]
			should strictly satisfy: 
		[task allowChangeParentViewAreaState willReturn: true.
		sourceContext shouldRestoreParentArea willReturn: false.
		(sourceContext isCreatedInContextOf: task) willReturn: false.
		sourceContext isChildrenShouldRestoreParentArea willReturn: true].
	
		activation shouldRestoreParentArea should be: #initialState
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testPrepareForEscapeToTaskWhenItParentOfSourceContext [

	| actual |
	[:task :sourceContext |
		activation shouldRestoreParentArea: #initialState.
		
		[activation prepareForEscapeTo: task fromContext: sourceContext]
			should strictly satisfy: 
		[task allowChangeParentViewAreaState willReturn: true.
		sourceContext shouldRestoreParentArea willReturn: false.
		(sourceContext isCreatedInContextOf: task) willReturn: true].
	
		activation shouldRestoreParentArea should be: false
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testPrepareForEscapeToTaskWhenSourceContextShouldRestoreParentArea [

	| actual |
	[:task :sourceContext |
		activation shouldRestoreParentArea: #initialState.
		
		[activation prepareForEscapeTo: task fromContext: sourceContext]
			should strictly satisfy: 
		[task allowChangeParentViewAreaState willReturn: true.
		sourceContext shouldRestoreParentArea willReturn: true].
	
		activation shouldRestoreParentArea should be: #initialState
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testPrepareForEscapeToTaskWhichNotAllowChangeParentArea [

	| actual |
	[:task :sourceContext |
		activation shouldRestoreParentArea: #initialState.
		
		[activation prepareForEscapeTo: task fromContext: sourceContext]
			should strictly satisfy: 
		[task allowChangeParentViewAreaState willReturn: false].
	
		activation shouldRestoreParentArea should be: #initialState
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testSharingParentAreaWithCurrentRequests [

	[:similarContext1 :activation1 :similarContext2 :activation2 |
		activation context: #taskContext.
		activation parentViewArea: #parentArea.
		
		[activation shareParentAreaWithCurrentRequests]
			should strictly satisfy: 
		[(guide currentTasksLike: #taskContext) willReturn: {similarContext1. similarContext2}.
		similarContext1 activation willReturn: activation1.
		activation1 parentViewArea: #parentArea.
		similarContext2 activation willReturn: activation2.
		activation2 parentViewArea: #parentArea].
	
	] runWithMocks 
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testShouldNotForgetCompleteTaskByDefault [

	activation shouldForgetCompleteTask should be: false
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testShouldNotRememberTaskByDefault [

	activation shouldRememberTask should be: false
]

{ #category : #tests }
PtyTaskActivationStrategyTests >> testShouldRestoreParentAreaByDefault [

	activation shouldRestoreParentArea should be: true
]
