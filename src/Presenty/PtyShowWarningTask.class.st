Class {
	#name : #PtyShowWarningTask,
	#superclass : #PtyShowMessageTask,
	#category : #'Presenty-NotificationTasks'
}

{ #category : #execution }
PtyShowWarningTask >> addActions [ 

	workplace addAction: 'ContinueExecution' returning: nil
]
