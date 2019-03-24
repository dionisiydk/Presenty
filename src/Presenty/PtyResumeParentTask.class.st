Class {
	#name : #PtyResumeParentTask,
	#superclass : #PtyTask,
	#instVars : [
		'returnContext',
		'result'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyResumeParentTask class >> from: aTaskContext [
	^self new returnContext: aTaskContext 
]

{ #category : #'instance creation' }
PtyResumeParentTask class >> from: aTaskContext with: anObject [
	^self new 
		returnContext: aTaskContext;
		result: anObject 
]

{ #category : #execution }
PtyResumeParentTask >> body [

	returnContext return: result
]

{ #category : #accessing }
PtyResumeParentTask >> result [
	^ result
]

{ #category : #accessing }
PtyResumeParentTask >> result: anObject [
	result := anObject
]

{ #category : #accessing }
PtyResumeParentTask >> returnContext [
	^ returnContext
]

{ #category : #accessing }
PtyResumeParentTask >> returnContext: anObject [
	returnContext := anObject
]
