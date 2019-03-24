Class {
	#name : #PtyInputToolPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'inputField',
		'editingStarted'
	],
	#category : #'Presenty-ScreenTools'
}

{ #category : #actions }
PtyInputToolPresenter >> appendChar: aCharacter [

	self clearInputIfNeeded.
	self input appendChar: aCharacter
]

{ #category : #accessing }
PtyInputToolPresenter >> backspaceButtonWithStyle: styleName [
	| button |
	button := PtyPresentersDecorator named: 'keyboardButton' withStyle: styleName.
	button addUserAction: [self deleteLastFieldChar].
	^button
]

{ #category : #accessing }
PtyInputToolPresenter >> buttonForChar: aCharacter withStyle: styleName [
	| button action |
	action := [ self appendChar: aCharacter ] asUserAction.
	action name: styleName.
	button := PtyButtonPresenter on: action.
	button titleContent: {PtySimpleLabelPresenter on: aCharacter asString}.
	^ button
]

{ #category : #accessing }
PtyInputToolPresenter >> clearButtonWithStyle: styleName [
	| button |
	button := PtyPresentersDecorator named: 'keyboardButton' withStyle: styleName.
	button addUserAction: [self clearInput].
	^button
]

{ #category : #actions }
PtyInputToolPresenter >> clearInput [

	self input clearInput 
]

{ #category : #actions }
PtyInputToolPresenter >> clearInputIfNeeded [
	editingStarted ifTrue: [^self].

	editingStarted := true.
	self clearInput 
]

{ #category : #actions }
PtyInputToolPresenter >> deleteLastFieldChar [

	editingStarted := true.
	
	self input deleteLastFieldChar 
]

{ #category : #'initialize-release' }
PtyInputToolPresenter >> initialize [ 
	super initialize.
	
	editingStarted := false
]

{ #category : #accessing }
PtyInputToolPresenter >> input [
	^ inputField input
]

{ #category : #accessing }
PtyInputToolPresenter >> inputField: anObject [
	inputField := anObject
]
