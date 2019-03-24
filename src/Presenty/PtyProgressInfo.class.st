Class {
	#name : #PtyProgressInfo,
	#superclass : #Object,
	#instVars : [
		'currentPosition',
		'endPosition'
	],
	#category : #'Presenty-BlockExecutionTasks'
}

{ #category : #'instance creation' }
PtyProgressInfo class >> currentPosition: aNumber end: aNumber2 [

	^self new 
		currentPosition: aNumber;
		endPosition: aNumber2
]

{ #category : #accessing }
PtyProgressInfo >> currentPosition [
	^ currentPosition
]

{ #category : #accessing }
PtyProgressInfo >> currentPosition: anObject [
	currentPosition := anObject
]

{ #category : #accessing }
PtyProgressInfo >> endPosition [
	^ endPosition
]

{ #category : #accessing }
PtyProgressInfo >> endPosition: anObject [
	endPosition := anObject
]

{ #category : #'initialize-release' }
PtyProgressInfo >> initialize [ 
	super initialize.
	currentPosition := 0.
	endPosition := 0
]

{ #category : #presentation }
PtyProgressInfo >> preferredPreviewPresenter [ 

	^PtySimpleLabelPresenter on: currentPosition asString , '/', endPosition asString withStyle: #progressInfo
]
