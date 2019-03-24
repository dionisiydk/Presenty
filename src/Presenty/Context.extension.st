Extension { #name : #Context }

{ #category : #'*Presenty-BlockExecutionTasks' }
Context >> progressInfo [

	^self receiver fetchProgressInfoFrom: self
]
