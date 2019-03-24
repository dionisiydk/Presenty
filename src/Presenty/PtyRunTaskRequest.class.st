Class {
	#name : #PtyRunTaskRequest,
	#superclass : #PtyTaskActivationRequest,
	#category : #'Presenty-Core'
}

{ #category : #execution }
PtyRunTaskRequest >> executeBy: aGuide inContext: aTaskContext [

	| result |
	aGuide context: aTaskContext.	
	
	"aTaskContext activation setUpNewViewArea."
		
	result := task body.
	
	^result
]
