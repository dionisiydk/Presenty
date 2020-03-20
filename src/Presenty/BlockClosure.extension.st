Extension { #name : #BlockClosure }

{ #category : #'*Presenty' }
BlockClosure >> asTask [
	^PtyPluggableTask from: self
]

{ #category : #'*Presenty' }
BlockClosure >> asTaskNamed: aString [
	^PtyPluggableTask from: self named: aString 
]
