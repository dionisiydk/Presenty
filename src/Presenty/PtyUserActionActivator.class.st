Class {
	#name : #PtyUserActionActivator,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'action'
	],
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtyUserActionActivator >> action [
	^ action
]

{ #category : #accessing }
PtyUserActionActivator >> action: anObject [
	action := anObject
]

{ #category : #'enabling/disabling' }
PtyUserActionActivator >> disable [

]

{ #category : #'enabling/disabling' }
PtyUserActionActivator >> enable [

]

{ #category : #activation }
PtyUserActionActivator >> executeAction [

	action execute
]

{ #category : #connecting }
PtyUserActionActivator >> hookupPresenter [

	self subclassResponsibility 
]

{ #category : #'morphic menu' }
PtyUserActionActivator >> populateSettingsMenu: aMenu for: aPrototype [
]

{ #category : #accessing }
PtyUserActionActivator >> presenter [
	^ presenter
]

{ #category : #accessing }
PtyUserActionActivator >> presenter: anObject [
	presenter := anObject
]
