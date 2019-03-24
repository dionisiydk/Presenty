Class {
	#name : #PtyTextField,
	#superclass : #PtyViewContainer,
	#instVars : [
		'textMorph'
	],
	#category : #'Presenty-UI'
}

{ #category : #accessing }
PtyTextField >> announcer [
	^textMorph announcer
]

{ #category : #accessing }
PtyTextField >> announcer: anAnnouncer [
	textMorph announcer: anAnnouncer 
]

{ #category : #accessing }
PtyTextField >> checkFilling [
	textMorph checkFilling 
]

{ #category : #accessing }
PtyTextField >> editDecorator: aPtyEditDecorator [ 
	textMorph editDecorator: aPtyEditDecorator 
]

{ #category : #accessing }
PtyTextField >> focus [

	textMorph focus
]

{ #category : #accessing }
PtyTextField >> focusSilently [

	textMorph focusSilently
]

{ #category : #initialization }
PtyTextField >> initialize [ 
	super initialize.
	
	self
		color: Color transparent;
		changeTableLayout;
		hResizing: #rigid;
		vResizing: #shrinkWrap;
		cornerStyle: #rounded;
		borderWidth: 3.
		
	textMorph := PtyTextInputMorph new.
	textMorph hResizing: #spaceFill.
	
	self add: textMorph 
]

{ #category : #accessing }
PtyTextField >> replaceWith: aTextField [

	super replaceWith: aTextField.
	
	aTextField textMorph editor selectAt: textMorph editDecorator cursorPosition.
	aTextField textMorph focusSilently.
]

{ #category : #accessing }
PtyTextField >> setValueSilently: aString [ 

	textMorph setContentsSilently: aString

]

{ #category : #accessing }
PtyTextField >> textConverter: aTextConverter [
	textMorph textConverter: aTextConverter
]

{ #category : #accessing }
PtyTextField >> textMorph [
	^ textMorph
]

{ #category : #accessing }
PtyTextField >> textMorph: anObject [
	textMorph := anObject
]

{ #category : #accessing }
PtyTextField >> value [ 
	^textMorph nativeContents 
]

{ #category : #accessing }
PtyTextField >> value: aString [ 

	textMorph newContents: aString.

]

{ #category : #accessing }
PtyTextField >> valueSpec: aStateSpec [ 
	textMorph valueSpec: aStateSpec
]
