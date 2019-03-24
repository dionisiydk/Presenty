Class {
	#name : #PtyTaskNavigatorTests,
	#superclass : #TestCase,
	#instVars : [
		'navigator',
		'guide'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyTaskNavigatorTests >> setUp [
	super setUp.
	
	guide := Mock new.
	navigator := PtyTaskNavigator for: guide.
]

{ #category : #tests }
PtyTaskNavigatorTests >> testAddingTask [
	
	navigator add: #first.

	navigator tasks size should equal: 1.
	navigator tasks last should be: #first.
]

{ #category : #tests }
PtyTaskNavigatorTests >> testClearTasks [
	
	navigator tasks: #(task1 task2) asOrderedCollection.

	navigator clearTasks.
	
	navigator tasks should be isEmpty
]

{ #category : #tests }
PtyTaskNavigatorTests >> testForgetAllButFirst [
	
	navigator tasks add: #task1; add: #task2; add: #task3.
	
	navigator forgetAllButFirst.
	
	navigator tasks should equal: #(task1)
		
	
]

{ #category : #tests }
PtyTaskNavigatorTests >> testForgetAllButFirstWhenNoTasks [
	
	navigator tasks removeAll.
	
	navigator forgetAllButFirst	
	
]

{ #category : #tests }
PtyTaskNavigatorTests >> testForgetCurrentRequest [
	
	[:task1 :task2 :task3 |
		navigator tasks add: task1; add: task2; add: task3.
		
		[navigator forgetCurrentRequest]
			should strictly satisfy: 
		[(guide isCurrentRequestIncludes: task3) willReturn: true.
		(guide isCurrentRequestIncludes: task2) willReturn: false].
	
		navigator tasks should equal: {task1. task2}
	] runWithMocks
	
	
]

{ #category : #tests }
PtyTaskNavigatorTests >> testForgetCurrentRequestWhenNoTasks [
	
	navigator tasks removeAll.
		
	navigator forgetCurrentRequest
]

{ #category : #tests }
PtyTaskNavigatorTests >> testForgetCurrentRequestWhenSingleTaskExists [
	
	navigator tasks add: #task1.
		
	navigator forgetCurrentRequest.
	
	navigator tasks should equal: #(task1)
]

{ #category : #tests }
PtyTaskNavigatorTests >> testForgetTask [
	
	[:first :second :last :task |
		navigator tasks add: first; add: second; add: last.
		
		[navigator forgetTask: task]
			should strictly satisfy: 
		[(first isCreatedInContextOf: task) willReturn: false.
		(second isCreatedInContextOf: task) willReturn: true.
		(last isCreatedInContextOf: task) willReturn: true].
	
		navigator tasks should haveSize: 1.
		navigator tasks should include: first.
		navigator tasks should not include: last.
		navigator tasks should not include: second.
	] runWithMocks
	
	
]

{ #category : #tests }
PtyTaskNavigatorTests >> testGettingLastTask [
	
	navigator tasks add: #first.
	navigator tasks add: #last.
	
	navigator lastTask should be: #last
]

{ #category : #tests }
PtyTaskNavigatorTests >> testHasEmptyTasksByDefault [
	
	navigator tasks should beKindOf: Collection.
	navigator tasks size should equal: 0
]
