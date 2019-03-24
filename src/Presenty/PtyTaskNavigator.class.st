Class {
	#name : #PtyTaskNavigator,
	#superclass : #Announcer,
	#instVars : [
		'guide',
		'tasks'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTaskNavigator class >> for: aGuide [
	^self new guide: aGuide
]

{ #category : #accessing }
PtyTaskNavigator >> add: aTask [

	tasks add: aTask 
]

{ #category : #accessing }
PtyTaskNavigator >> clearTasks [
	tasks removeAll
]

{ #category : #navigation }
PtyTaskNavigator >> forgetAllButFirst [

	| first |
	
	tasks ifEmpty: [^self].

	first := 	tasks first.
		
	tasks reset.
	
	tasks add: first
]

{ #category : #navigation }
PtyTaskNavigator >> forgetCurrentRequest [
	
	tasks ifEmpty: [^self].

	[tasks size > 1 and: [guide isCurrentRequestIncludes: self lastTask]] whileTrue: [
		 tasks remove: self lastTask
	]
]

{ #category : #navigation }
PtyTaskNavigator >> forgetTask: aTask [

	tasks removeAllSuchThat: [:each |
		
		each isCreatedInContextOf: aTask
				
		].
	

]

{ #category : #accessing }
PtyTaskNavigator >> guide [
	^ guide
]

{ #category : #accessing }
PtyTaskNavigator >> guide: anObject [
	guide := anObject
]

{ #category : #'initialize-release' }
PtyTaskNavigator >> initialize [
	super initialize.
	
	tasks := OrderedCollection new.
]

{ #category : #accessing }
PtyTaskNavigator >> lastTask [
	^tasks last
]

{ #category : #accessing }
PtyTaskNavigator >> tasks [
	^ tasks
]

{ #category : #accessing }
PtyTaskNavigator >> tasks: anObject [
	tasks := anObject
]
