Extension { #name : #MouseMoveEvent }

{ #category : #'*Presenty-Core' }
MouseMoveEvent >> direction [

	^position - startPoint 
]
