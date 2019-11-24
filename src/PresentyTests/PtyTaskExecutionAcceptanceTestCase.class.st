Class {
	#name : #PtyTaskExecutionAcceptanceTestCase,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'user'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #testing }
PtyTaskExecutionAcceptanceTestCase class >> isAbstract [ 	
	^self = PtyTaskExecutionAcceptanceTestCase 
]

{ #category : #running }
PtyTaskExecutionAcceptanceTestCase >> setUp [
	super setUp.
	
	workplace defaultTaskExecutionPriority: Processor activePriority + 1.
	user := PtyUser of: workplace.
]
