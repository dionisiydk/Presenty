Extension { #name : #Object }

{ #category : #'*PrototypesManager' }
Object >> populatePrototypeConsumerMenu: aMenu [

	aMenu add: 'explore' translated 
		target: self selector: #explore argumentList: #().
	
	aMenu add: 'browse' translated 
		target: self selector: #browse argumentList: #().
]

{ #category : #'*PrototypesManager' }
Object >> ptyPrototypeClass [

	^PtyPrototypeClass on: self class
]

{ #category : #'*PrototypesManager' }
Object >> readSampleProperitiesFrom: someRequestedObject [

	
]
