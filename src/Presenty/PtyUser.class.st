Class {
	#name : #PtyUser,
	#superclass : #Object,
	#instVars : [
		'workplace'
	],
	#category : #'Presenty-NewCore'
}

{ #category : #'instance creation' }
PtyUser class >> guide: aGuide [

	^self new guide: aGuide 
]

{ #category : #'instance creation' }
PtyUser class >> of: aWorkplace [

	^self new 
		workplace: aWorkplace 
]

{ #category : #'as yet unclassified' }
PtyUser >> confirm: userMessage [

	^workplace requestUserFor: (PtyShowConfirmationTask with: userMessage)
]

{ #category : #requests }
PtyUser >> executeTask: aTask [

  self shouldBeImplemented.
]

{ #category : #requests }
PtyUser >> goToBack [

	workplace taskNavigator forgetCurrentRequest.
	
	workplace retryLastTask 
	
]

{ #category : #requests }
PtyUser >> goToStart [

	workplace taskNavigator forgetAllButFirst.
	
	workplace retryLastTask 
]

{ #category : #accessing }
PtyUser >> guide [
	^ workplace
]

{ #category : #accessing }
PtyUser >> guide: anObject [
	workplace := anObject
]

{ #category : #'as yet unclassified' }
PtyUser >> input: aFields [

	^self goTo: (PtyInputRequisitiesTask on: aFields)
]

{ #category : #'as yet unclassified' }
PtyUser >> input: aFields for: taskName [
	
	^workplace requestUserFor:  (PtyModalInputRequisitiesTask on: aFields)
]

{ #category : #requests }
PtyUser >> lookAt: aBlockOrPresenter [

	^workplace requestUserFor: aBlockOrPresenter asUserRequestTask
]

{ #category : #requests }
PtyUser >> lookAt: aPresenter and: uiActionBlock [

	| task |
	task := PtyUserRequestTask new 
		presenter: aPresenter;
		action: uiActionBlock.
		
	^workplace requestUserFor: task
]

{ #category : #'as yet unclassified' }
PtyUser >> lookAtList: itemsCollection of: itemsClass [

	| listTask |
	listTask := PtyShowListTask forItems: itemsCollection of: itemsClass.
	
	^workplace requestUserFor: listTask
]

{ #category : #requests }
PtyUser >> lookAtViewArea [
	^workplace requestUserFor: PtyUserRequestTask new
]

{ #category : #requests }
PtyUser >> lookAtViewAreaAnd: uiActionBlock [

	| task |
	task := PtyUserRequestTask new 
		action: uiActionBlock.
	^workplace requestUserFor: task
]

{ #category : #'as yet unclassified' }
PtyUser >> navigateThrough: items of: itemClass [

	| task |
	task := PtyItemsNavigationTask new.
	task 
		items: items;
		itemsName: itemClass.
	^workplace requestUserFor: task
]

{ #category : #'as yet unclassified' }
PtyUser >> select: itemsClass from: itemsCollection [

	| listTask |
	listTask := (PtyItemsRequestTask forItems: itemsCollection of: itemsClass).

	^workplace requestUserFor: listTask
]

{ #category : #requests }
PtyUser >> stopCurrentTask [

	| navigator |
	
	navigator := workplace taskNavigator.
	
	navigator forgetTask: workplace context task.
	
	workplace retryLastTask
]

{ #category : #'as yet unclassified' }
PtyUser >> wait: actionName while: aBlock [
	
	workplace requestUserFor: (PtyBlockExecutionTask named: actionName with: aBlock)
	
	
	
]

{ #category : #'as yet unclassified' }
PtyUser >> waitWhile: aBlock [
	
	self wait: nil while: aBlock 
	
	
	
]

{ #category : #'as yet unclassified' }
PtyUser >> warn: userMessage [

	^workplace requestUserFor: (PtyShowWarningTask with: userMessage)
]

{ #category : #accessing }
PtyUser >> workplace [
	^ workplace
]

{ #category : #accessing }
PtyUser >> workplace: anObject [
	workplace := anObject
]
