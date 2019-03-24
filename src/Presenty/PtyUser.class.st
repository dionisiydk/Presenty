Class {
	#name : #PtyUser,
	#superclass : #Object,
	#instVars : [
		'guide'
	],
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyUser class >> guide: aGuide [

	^self new guide: aGuide 
]

{ #category : #'*Presenty-NotificationTasks' }
PtyUser >> confirm: userMessage [

	^guide requestUserFor: (PtyShowConfirmationTask with: userMessage)
]

{ #category : #requests }
PtyUser >> goToBack [

	guide taskNavigator forgetCurrentRequest.
	
	guide retryLastTask 
	
]

{ #category : #requests }
PtyUser >> goToStart [

	guide taskNavigator forgetAllButFirst.
	
	guide retryLastTask 
]

{ #category : #accessing }
PtyUser >> guide [
	^ guide
]

{ #category : #accessing }
PtyUser >> guide: anObject [
	guide := anObject
]

{ #category : #'*Presenty-Editor' }
PtyUser >> input: aFields [

	^self goTo: (PtyInputRequisitiesTask on: aFields)
]

{ #category : #'*Presenty-Editor' }
PtyUser >> input: aFields for: taskName [
	
	^guide requestUserFor:  (PtyModalInputRequisitiesTask on: aFields)
]

{ #category : #requests }
PtyUser >> lookAt: aBlockOrPresenter [

	^guide requestUserFor: aBlockOrPresenter asUserRequestTask
]

{ #category : #requests }
PtyUser >> lookAt: aPresenter and: uiActionBlock [

	| task |
	task := PtyUserRequestTask new 
		presenter: aPresenter;
		action: uiActionBlock.
		
	^guide requestUserFor: task
]

{ #category : #'*Presenty-ShowListTasks' }
PtyUser >> lookAtList: itemsCollection of: itemsClass [

	| listTask |
	listTask := PtyShowListTask forItems: itemsCollection of: itemsClass.
	
	^guide requestUserFor: listTask
]

{ #category : #requests }
PtyUser >> lookAtViewArea [
	^guide requestUserFor: PtyUserRequestTask new
]

{ #category : #requests }
PtyUser >> lookAtViewAreaAnd: uiActionBlock [

	| task |
	task := PtyUserRequestTask new 
		action: uiActionBlock.
	^guide requestUserFor: task
]

{ #category : #'*Presenty-ItemSelectionTasks' }
PtyUser >> navigateThrough: items of: itemClass [

	| task |
	task := PtyItemsNavigationTask new.
	task 
		items: items;
		itemsName: itemClass.
	^guide requestUserFor: task
]

{ #category : #'*Presenty-ItemSelectionTasks' }
PtyUser >> select: itemsClass from: itemsCollection [

	| listTask |
	listTask := (PtyItemsRequestTask forItems: itemsCollection of: itemsClass).

	^guide requestUserFor: listTask
]

{ #category : #requests }
PtyUser >> stopCurrentTask [

	| navigator |
	
	navigator := guide taskNavigator.
	
	navigator forgetTask: guide context task.
	
	guide retryLastTask
]

{ #category : #'*Presenty-BlockExecutionTasks' }
PtyUser >> wait: actionName while: aBlock [
	
	guide requestUserFor: (PtyBlockExecutionTask named: actionName with: aBlock)
	
	
	
]

{ #category : #'*Presenty-BlockExecutionTasks' }
PtyUser >> waitWhile: aBlock [
	
	self wait: nil while: aBlock 
	
	
	
]

{ #category : #'*Presenty-NotificationTasks' }
PtyUser >> warn: userMessage [

	^guide requestUserFor: (PtyShowWarningTask with: userMessage)
]
