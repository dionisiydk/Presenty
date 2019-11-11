Class {
	#name : #PtyShowConfirmationTask,
	#superclass : #PtyShowMessageTask,
	#category : #'Presenty-NotificationTasks'
}

{ #category : #execution }
PtyShowConfirmationTask >> addActions [ 
	
	workplace addAction: 'ReturnTrue' returning: true.
	workplace addAction: 'ReturnFalse' returning: false
]

{ #category : #accessing }
PtyShowConfirmationTask >> defaultActivationStrategy [ 

	^PtySeparatedTaskActivationStrategy new
		areaActivator: PtyModalAreaActivator new
]
