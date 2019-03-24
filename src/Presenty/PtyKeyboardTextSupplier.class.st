Class {
	#name : #PtyKeyboardTextSupplier,
	#superclass : #PtyUserActionActivator,
	#category : #'Presenty-UserActionActivators'
}

{ #category : #connecting }
PtyKeyboardTextSupplier >> hookupPresenter [ 

	presenter view on: #keyStroke send: #keyPressed: to: self
]

{ #category : #connecting }
PtyKeyboardTextSupplier >> keyPressed: evt [

	| key keyName |

	key := evt keyCharacter.
	keyName :=  key printString. 
	key == Character tab ifTrue: [^self].
	((keyName beginsWith: '$') or: [key isSeparator])
		ifTrue: [action executeWith: key asString]
	
]
