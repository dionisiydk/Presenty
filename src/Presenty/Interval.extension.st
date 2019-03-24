Extension { #name : #Interval }

{ #category : #'*Presenty-BlockExecutionTasks' }
Interval >> fetchProgressInfoFrom: aContext [

	^PtyProgressInfo currentPosition: (aContext tempAt: 3) end: self size
]
