Extension { #name : #PtyUser }

{ #category : #'*Presenty-NotificationTasks' }
PtyUser >> confirm: userMessage [

	^guide requestUserFor: (PtyShowConfirmationTask with: userMessage)
]

{ #category : #'*Presenty-Editor' }
PtyUser >> input: aFields [

	^self goTo: (PtyInputRequisitiesTask on: aFields)
]

{ #category : #'*Presenty-Editor' }
PtyUser >> input: aFields for: taskName [
	
	^guide requestUserFor:  (PtyModalInputRequisitiesTask on: aFields)
]

{ #category : #'*Presenty-ShowListTasks' }
PtyUser >> lookAtList: itemsCollection of: itemsClass [

	| listTask |
	listTask := PtyShowListTask forItems: itemsCollection of: itemsClass.
	
	^guide requestUserFor: listTask
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
