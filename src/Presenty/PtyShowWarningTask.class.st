Class {
	#name : #PtyShowWarningTask,
	#superclass : #PtyShowMessageTask,
	#category : #'Presenty-NotificationTasks'
}

{ #category : #execution }
PtyShowWarningTask >> addActions [ 

	worker addAction: 'ContinueExecution' returning: nil
]
