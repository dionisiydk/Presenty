Class {
	#name : #PtyShowWarningTask,
	#superclass : #PtyShowMessageTask,
	#category : #'Presenty-NotificationTasks'
}

{ #category : #execution }
PtyShowWarningTask >> addActions [ 

	guide addAction: 'ContinueExecution' returning: nil
]
