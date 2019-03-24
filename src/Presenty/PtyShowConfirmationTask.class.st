Class {
	#name : #PtyShowConfirmationTask,
	#superclass : #PtyShowMessageTask,
	#category : #'Presenty-NotificationTasks'
}

{ #category : #execution }
PtyShowConfirmationTask >> addActions [ 
	
	guide addAction: 'ReturnTrue' returning: true.
	guide addAction: 'ReturnFalse' returning: false
]

{ #category : #accessing }
PtyShowConfirmationTask >> defaultActivationStrategy [ 

	^PtySeparatedTaskActivationStrategy new
		areaActivator: PtyModalAreaActivator new
]
