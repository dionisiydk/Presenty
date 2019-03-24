Class {
	#name : #PtyMouseClickUserActionActivator,
	#superclass : #PtyUserActionActivator,
	#category : #'Presenty-UserActionActivators'
}

{ #category : #connecting }
PtyMouseClickUserActionActivator >> hookupPresenter [ 

	presenter view on: #click send: #executeAction to: self
]
