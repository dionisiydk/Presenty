Class {
	#name : #PtyForkTaskTests,
	#superclass : #PtyTaskTestCase,
	#instVars : [
		'targetTask',
		'forkActivation',
		'taskContext'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyForkTaskTests >> setUp [
	super setUp.
	
	targetTask := Mock new.
	forkActivation := Mock new.
	taskContext := Mock new.
	
	task targetTask: targetTask. 
]

{ #category : #running }
PtyForkTaskTests >> setUpStubs [

	guide context willReturn: taskContext.
	taskContext activation willReturn: forkActivation 
]

{ #category : #running }
PtyForkTaskTests >> taskClass [ 
	^PtyForkTask
]

{ #category : #tests }
PtyForkTaskTests >> testExecutionWhenNoUserRequests [

	[ 
		[task body should be: #result]
			should strictly satisfy: 
		[self setUpStubs.
		(guide requestUserFor: targetTask) willReturn: #result]
	] runWithMocks 

]

{ #category : #tests }
PtyForkTaskTests >> testExecutionWhenUserRequestsRaisedAndTaskCurrent [

	[:viewArea | 
		task forkAreaPanelName: #forkPanelName.
		
		[task body]
			should strictly satisfy:
		[self setUpStubs.
		(guide requestUserFor: targetTask) willRaise: PtyUserRequest new.
		(guide isCurrentRequestIncludesTask: task) willReturn: true.
		guide viewArea willReturn: viewArea.
		viewArea name: 'ForkedArea'.
		forkActivation embedCurrentAreaToParentOn: #forkPanelName.
		forkActivation shareParentAreaWithCurrentRequests.
		forkActivation parentViewArea willReturn: #forkArea.
		guide viewArea: #forkArea]
	] runWithMocks 

]

{ #category : #tests }
PtyForkTaskTests >> testExecutionWhenUserRequestsRaisedButTaskNotCurrent [

	[ 
		[task body]
			should raise: PtyUserRequest andStrictlySatisfy: 
		[self setUpStubs.
		(guide requestUserFor: targetTask) willRaise: PtyUserRequest new.
		(guide isCurrentRequestIncludesTask: task) willReturn: false]
	] runWithMocks 

]
