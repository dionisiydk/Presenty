Class {
	#name : #PtyTaskExecutionAcceptanceTestCase,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'user'
	],
	#category : #'Presenty-Tests-Tasks'
}

{ #category : #testing }
PtyTaskExecutionAcceptanceTestCase class >> isAbstract [ 	
	^self = PtyTaskExecutionAcceptanceTestCase 
]

{ #category : #running }
PtyTaskExecutionAcceptanceTestCase >> setUp [
	super setUp.
	
	workplace defaultTaskExecutionPriority: Processor activePriority + 1.
	user := PtyUser new.
	workplace user: user
]
