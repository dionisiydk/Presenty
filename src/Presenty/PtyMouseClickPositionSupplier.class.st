Class {
	#name : #PtyMouseClickPositionSupplier,
	#superclass : #PtyParameterizedActivator,
	#category : #'Presenty-UserActionActivators'
}

{ #category : #connecting }
PtyMouseClickPositionSupplier >> handleClick: evt [

	action executeWith: evt position
]

{ #category : #connecting }
PtyMouseClickPositionSupplier >> hookupPresenter [ 

	presenter view on: #click send: #handleClick: to: self
]
