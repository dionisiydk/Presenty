Class {
	#name : #PtyButtonUserActionActivator,
	#superclass : #PtyUserActionActivator,
	#instVars : [
		'buttonsBarName',
		'button'
	],
	#category : #'Presenty-UserActionActivators'
}

{ #category : #accessing }
PtyButtonUserActionActivator >> buttonsBarName [
	^ buttonsBarName
]

{ #category : #accessing }
PtyButtonUserActionActivator >> buttonsBarName: anObject [
	buttonsBarName := anObject
]

{ #category : #'enabling/disabling' }
PtyButtonUserActionActivator >> disable [
	button view hide
]

{ #category : #'enabling/disabling' }
PtyButtonUserActionActivator >> enable [
	button view show
]

{ #category : #connecting }
PtyButtonUserActionActivator >> hookupPresenter [
	button := PtyButtonPresenter on: action copy.
	presenter showItem: button on: buttonsBarName
]

{ #category : #'initialize-release' }
PtyButtonUserActionActivator >> initialize [ 
	super initialize.
	
	buttonsBarName := 'buttonsBar'.
]
