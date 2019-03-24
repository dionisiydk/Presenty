Class {
	#name : #PtyTextInputPresenter,
	#superclass : #PtyPresenter,
	#instVars : [
		'textConverter',
		'textSpec'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #accessing }
PtyTextInputPresenter class >> defaultView [ 

	^PtyTextField new
]

{ #category : #commands }
PtyTextInputPresenter >> appendChar: aCharacter [

	model isFull ifTrue: [^self].

	view value: view value, aCharacter asString
]

{ #category : #commands }
PtyTextInputPresenter >> clearInput [

	view value: String empty 
]

{ #category : #commands }
PtyTextInputPresenter >> deleteLastFieldChar [

	view value isEmpty ifTrue: [^self].
	^ view value: view value allButLast
]

{ #category : #accessing }
PtyTextInputPresenter >> focus [
	view focus
]

{ #category : #private }
PtyTextInputPresenter >> hookupModel [
	super hookupModel.

	model on: PtyValueChanged send: #updateView to: self.

]

{ #category : #presentation }
PtyTextInputPresenter >> hookupView [
	view announcer on: PtyInputFocused send: #announce: to: self.
	view announcer on: PtyValueChanged send: #updateModel to: self.
	view announcer on: PtyInputComplete, PtyInputSubmitted, PtyInputLeftRequested send: #announce: to: self
]

{ #category : #commands }
PtyTextInputPresenter >> setText: aString [

	view value: aString 
]

{ #category : #presentation }
PtyTextInputPresenter >> showViewItems [
	view valueSpec: textSpec.
	view editDecorator: model editDecorator.
	view textConverter: textConverter.

	self updateView.
	self hookupView.
]

{ #category : #accessing }
PtyTextInputPresenter >> textConverter [
	^ textConverter
]

{ #category : #accessing }
PtyTextInputPresenter >> textConverter: anObject [
	textConverter := anObject
]

{ #category : #accessing }
PtyTextInputPresenter >> textSpec [
	^ textSpec
]

{ #category : #accessing }
PtyTextInputPresenter >> textSpec: spec [
	textSpec := spec
]

{ #category : #private }
PtyTextInputPresenter >> unhookModel [
	super unhookModel.

	model unsubscribe: self
]

{ #category : #presentation }
PtyTextInputPresenter >> unhookView [
	view announcer unsubscribe: self
]

{ #category : #private }
PtyTextInputPresenter >> updateModel [

	self unhookModel.
	[model value: (textConverter readValueFrom: view value)]
		ensure: [self hookupModel]
]

{ #category : #private }
PtyTextInputPresenter >> updateView [

	view setValueSilently: model printValue
]

{ #category : #presentation }
PtyTextInputPresenter >> value [
	^view value
]

{ #category : #presentation }
PtyTextInputPresenter >> value: aString [
	view value: aString.
]
