Extension { #name : #BlockClosure }

{ #category : #'*Presenty-Core' }
BlockClosure >> asTask [
	^PtyPluggableTask from: self
]

{ #category : #'*Presenty-Core' }
BlockClosure >> asTaskNamed: aString [
	^PtyPluggableTask from: self named: aString 
]

{ #category : #'*Presenty-Core' }
BlockClosure >> asUserAction [
	^PtyPluggableUserAction from: self
]

{ #category : #'*Presenty-Core' }
BlockClosure >> asUserRequestTask [
	^PtyUserRequestTask new
		action: self
]
