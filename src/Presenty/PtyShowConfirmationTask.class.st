Class {
	#name : #PtyShowConfirmationTask,
	#superclass : #PtyShowMessageTask,
	#category : #'Presenty-NotificationTasks'
}

{ #category : #execution }
PtyShowConfirmationTask >> addActions [ 
	
	worker addAction: 'ReturnTrue' returning: true.
	worker addAction: 'ReturnFalse' returning: false
]

{ #category : #accessing }
PtyShowConfirmationTask >> defaultActivationStrategy [ 

	^PtySeparatedTaskActivationStrategy new
		areaActivator: PtyModalAreaActivator new
]
