Class {
	#name : #PtyRealInteractionAcceptanceTestCase,
	#superclass : #PtyWorkplaceTestCase,
	#instVars : [
		'user'
	],
	#category : #'PresentyTests-NewCore'
}

{ #category : #testing }
PtyRealInteractionAcceptanceTestCase class >> isAbstract [ 	
	^self = PtyRealInteractionAcceptanceTestCase 
]

{ #category : #running }
PtyRealInteractionAcceptanceTestCase >> setUp [
	super setUp.
	
	workplace defaultTaskExecutionPriority: Processor activePriority + 1.
	user := PtyUser of: workplace.
]
