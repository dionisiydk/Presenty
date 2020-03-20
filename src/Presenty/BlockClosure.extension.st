Extension { #name : #BlockClosure }

{ #category : #'*Presenty' }
BlockClosure >> asTask [
	^PtyPluggableTask from: self
]
