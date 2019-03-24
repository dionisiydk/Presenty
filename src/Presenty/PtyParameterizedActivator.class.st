Class {
	#name : #PtyParameterizedActivator,
	#superclass : #PtyUserActionActivator,
	#instVars : [
		'basicActivator'
	],
	#category : #'Presenty-UserActionActivators'
}

{ #category : #accessing }
PtyParameterizedActivator >> basicActivator [
	^ basicActivator
]

{ #category : #accessing }
PtyParameterizedActivator >> basicActivator: anObject [
	basicActivator := anObject
]

{ #category : #connecting }
PtyParameterizedActivator >> hookupPresenter [ 

	basicActivator ifNil: [^self].
	
	basicActivator presenter: presenter.
	basicActivator action: [self executeAction] asUserAction.
	basicActivator hookupPresenter 
]

{ #category : #'morphic menu' }
PtyParameterizedActivator >> populateSettingsMenu: aMenu for: aPrototype [
	| subMenu |
	super populateSettingsMenu: aMenu for: aPrototype.
	
	basicActivator ifNotNil: [
		basicActivator populateSettingsMenu: aMenu for: aPrototype 
	].
	
	subMenu := MenuMorph new defaultTarget: self.

	PtyUserActionActivator allSubclasses do: [ :eachClass | 
		subMenu
			add: eachClass name
			target: self
			selector: #basicActivator:
			argumentList: {eachClass new} ].
		
	aMenu add: 'change basic activator' translated subMenu: subMenu
]
