Class {
	#name : #PtyTextLabel,
	#superclass : #PtyTextMorph,
	#instVars : [
		'labelName'
	],
	#category : #'Presenty-UI'
}

{ #category : #menu }
PtyTextLabel >> addCustomMenuItems: aCustomMenu hand: aHandMorph [

	super addCustomMenuItems: aCustomMenu hand: aHandMorph.
	aCustomMenu addLine.
	aCustomMenu add: 'set current language text' translated action: #setCurrentTranslation.	
]

{ #category : #accessing }
PtyTextLabel >> cleanupYourselfForPrototype [ 
	super cleanupYourselfForPrototype.
	labelName ifNil: [^self].
	
	self newContents: labelName
]

{ #category : #testing }
PtyTextLabel >> handlesKeyboard: evt [

	^false
]

{ #category : #testing }
PtyTextLabel >> handlesMouseDown: evt [
	^false
]

{ #category : #accessing }
PtyTextLabel >> labelName [
	^ labelName
]

{ #category : #accessing }
PtyTextLabel >> labelName: anObject [
	labelName := anObject
]

{ #category : #accessing }
PtyTextLabel >> setCurrentTranslation [

	| translation translator |
	translator := self findBuildContext guide translator.
	
	translation := UIManager default 
		multiLineRequest: 'Input translation to ', translator currentLanguage name
		centerAt: Sensor cursorPoint
		initialAnswer: (translator translate: labelName)
		answerHeight: 150.
	(translation isNil or: [translation isEmpty]) ifTrue: [^self].
	
 	translator addTranslation: translation for: labelName.
	self translateContentBy: translator
]

{ #category : #testing }
PtyTextLabel >> takesKeyboardFocus [ 
	^false
]

{ #category : #accessing }
PtyTextLabel >> translateContentBy: aTranslator [

	self newContents: (aTranslator translate: labelName)
]
