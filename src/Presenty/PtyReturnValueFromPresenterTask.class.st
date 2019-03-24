Class {
	#name : #PtyReturnValueFromPresenterTask,
	#superclass : #PtyTask,
	#instVars : [
		'presenter',
		'result'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyReturnValueFromPresenterTask class >> from: aPresenter [
	^self new 
		presenter: aPresenter
]

{ #category : #'instance creation' }
PtyReturnValueFromPresenterTask class >> from: aPresenter with: anObject [
	^self new 
		presenter: aPresenter;
		result: anObject 
]

{ #category : #execution }
PtyReturnValueFromPresenterTask >> body [ 

	presenter context return: result
]

{ #category : #accessing }
PtyReturnValueFromPresenterTask >> presenter [
	^ presenter
]

{ #category : #accessing }
PtyReturnValueFromPresenterTask >> presenter: anObject [
	presenter := anObject
]

{ #category : #accessing }
PtyReturnValueFromPresenterTask >> result [
	^ result
]

{ #category : #accessing }
PtyReturnValueFromPresenterTask >> result: anObject [
	result := anObject
]
