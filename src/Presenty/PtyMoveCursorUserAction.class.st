Class {
	#name : #PtyMoveCursorUserAction,
	#superclass : #PtyTextEditorUserAction,
	#category : #'Presenty-TextEditor'
}

{ #category : #execution }
PtyMoveCursorUserAction >> executeWith: aMovement [
	
	aMovement applyTo: presenter
]

{ #category : #'morphic menu' }
PtyMoveCursorUserAction >> populateSettingsMenu: aMenu for: aPrototype [
	| subMenu |
	super populateSettingsMenu: aMenu for: aPrototype.
	
	subMenu := MenuMorph new defaultTarget: self.

	PtyTextCursorMovement allSubclasses do: [ :eachClass | 
		subMenu
			add: eachClass name
			target: self
			selector: #parameter:
			argumentList: {eachClass new} ].
		
	aMenu add: 'change movement' translated subMenu: subMenu
]
