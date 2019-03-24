Extension { #name : #SequenceableCollection }

{ #category : #'*Presenty-Tasks' }
SequenceableCollection >> asPtyModel [ 

	^PtyListModel on: self asOrderedCollection 
]
