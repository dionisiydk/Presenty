Class {
	#name : #PtyTaskReturnRequest,
	#superclass : #PtyTaskActivationRequest,
	#instVars : [
		'returnValue'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyTaskReturnRequest class >> value: anObject [

	^self new 
		returnValue: anObject 
]

{ #category : #execution }
PtyTaskReturnRequest >> executeBy: aGuide inContext: aTaskContext [

	| newContext |

	newContext := aGuide context prepareReturnContextTo: aTaskContext.	
	
	aGuide context: newContext.	
	
	^returnValue
]

{ #category : #accessing }
PtyTaskReturnRequest >> returnValue [
	^ returnValue
]

{ #category : #accessing }
PtyTaskReturnRequest >> returnValue: anObject [
	returnValue := anObject
]
