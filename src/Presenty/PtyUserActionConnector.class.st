Class {
	#name : #PtyUserActionConnector,
	#superclass : #Object,
	#instVars : [
		'activators'
	],
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtyUserActionConnector >> activators [
	^ activators
]

{ #category : #accessing }
PtyUserActionConnector >> activators: anObject [
	activators := anObject
]

{ #category : #accessing }
PtyUserActionConnector >> addNewActivatorOfClass: aClass [ 
	activators add: aClass new
]

{ #category : #'connecting tasks' }
PtyUserActionConnector >> connectAction: anUserAction to: aPresenter [

	activators do: [:each | 
		each 
			presenter: aPresenter; 
			action: anUserAction;
			hookupPresenter]
]

{ #category : #accessing }
PtyUserActionConnector >> copyAsNewInstance [
	^self veryDeepCopy 
]

{ #category : #accessing }
PtyUserActionConnector >> copyAsPrototype [
	| copy |
	copy := self copy.
	copy activators: (activators collect: [:each | each copyAsPrototype]).
	^copy
]

{ #category : #accessing }
PtyUserActionConnector >> deleteActivator: anUserActivator [ 

	activators remove: anUserActivator 
]

{ #category : #'morphic menu' }
PtyUserActionConnector >> deleteActivatorWithUserRequest: anUserActivator [

	| answer |
	answer := UIManager default confirm: 'Do you want remove ', anUserActivator printString, '?'.
	answer ifFalse: [^self].
	
	self deleteActivator: anUserActivator 
]

{ #category : #'initialize-release' }
PtyUserActionConnector >> initialize [ 
	super initialize.
	
	activators := OrderedCollection new.
]

{ #category : #'morphic menu' }
PtyUserActionConnector >> populateCurrentActivatorsMenu: aMenu for: aPrototype [
	| subMenu |
	activators do: [ :eachActivator | 
		subMenu := MenuMorph new defaultTarget: self.
	
		subMenu 
			add: 'remove activator' translated 
			target: self	
			selector: #deleteActivatorWithUserRequest: 
			argumentList: {eachActivator}.	
		
		eachActivator populateSettingsMenu: subMenu for: aPrototype.
		aMenu add: eachActivator asString subMenu: subMenu ].
	
]

{ #category : #'morphic menu' }
PtyUserActionConnector >> populateNewActivatorsMenu: aMenu for: aPrototype [
	| subMenu |
	subMenu := MenuMorph new defaultTarget: self.

	PtyUserActionActivator allSubclasses do: [ :eachClass | 
		subMenu
			add: eachClass name
			target: (aPrototype proxyForSample: self)
			selector: #addNewActivatorOfClass:
			argumentList: {eachClass} ].
		
	aMenu add: 'add new activator' translated subMenu: subMenu
]

{ #category : #'morphic menu' }
PtyUserActionConnector >> populateSettingsMenu: aMenu for: aPrototype [
	
	self populateCurrentActivatorsMenu: aMenu for: aPrototype.
	
	aMenu addLine.
	
	self populateNewActivatorsMenu: aMenu for: aPrototype.

]
