Class {
	#name : #PtyPinpadActivator,
	#superclass : #PtyUserActionActivator,
	#category : #'Presenty-ScreenTools'
}

{ #category : #connecting }
PtyPinpadActivator >> hookupPresenter [
	| pinpad |
	pinpad := PtyPinpadPresenter digital.
	pinpad inputField: presenter.
	presenter guide viewArea showItem: pinpad on: 'visualKeyboard'
]
