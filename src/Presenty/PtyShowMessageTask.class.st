Class {
	#name : #PtyShowMessageTask,
	#superclass : #PtyTask,
	#instVars : [
		'message'
	],
	#category : #'Presenty-NotificationTasks'
}

{ #category : #'instance creation' }
PtyShowMessageTask class >> with: stringMessage [

	^self new 
		message: stringMessage 
]

{ #category : #execution }
PtyShowMessageTask >> addActions [
	self subclassResponsibility
]

{ #category : #execution }
PtyShowMessageTask >> body [ 

	self addActions.
	
	self showUserMessage 
]

{ #category : #accessing }
PtyShowMessageTask >> message [
	^ message
]

{ #category : #accessing }
PtyShowMessageTask >> message: anObject [
	message := anObject
]

{ #category : #execution }
PtyShowMessageTask >> showUserMessage [

	^user lookAt: (PtyLabelPresenter textNamed: message withStyle: #userMessage)
]
