Class {
	#name : #PtyShortcutActionActivator,
	#superclass : #PtyUserActionActivator,
	#instVars : [
		'shortcut'
	],
	#category : #'Presenty-UserActionActivators'
}

{ #category : #connecting }
PtyShortcutActionActivator >> hookupPresenter [ 

	presenter view on: shortcut do: [action execute].
	presenter view takeKeyboardFocus 
	
]

{ #category : #'initialize-release' }
PtyShortcutActionActivator >> initialize [ 
	super initialize.
	
	shortcut := KMNoShortcut new
]

{ #category : #'morphic menu' }
PtyShortcutActionActivator >> populateSettingsMenu: aMenu for: aPrototype [
	super populateSettingsMenu: aMenu for: aPrototype.
	
	aMenu 
		add: 'change shortcut (' , shortcut printString , ')' 
		target: (aPrototype proxyForSample: self) 
		action: #requestShortcut.
		

]

{ #category : #printing }
PtyShortcutActionActivator >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: shortcut printString;
		nextPut: $)
]

{ #category : #'morphic menu' }
PtyShortcutActionActivator >> requestShortcut [

	| catcher |
	
	catcher := KMCatcherMorph for: (KMKeymap
			shortcut: shortcut
			action: []).
	catcher on: #keyStroke send: #value to: [
		shortcut := catcher shortcut.
		catcher delete].

	catcher openCenteredInWorld.
	
	

]

{ #category : #accessing }
PtyShortcutActionActivator >> shortcut [
	^ shortcut
]

{ #category : #accessing }
PtyShortcutActionActivator >> shortcut: anObject [
	shortcut := anObject
]
