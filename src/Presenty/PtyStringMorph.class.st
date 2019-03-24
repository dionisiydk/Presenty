Class {
	#name : #PtyStringMorph,
	#superclass : #StringMorph,
	#category : #'Presenty-UI'
}

{ #category : #menu }
PtyStringMorph >> addCustomMenuItems: aCustomMenu hand: aHandMorph [

	super addCustomMenuItems: aCustomMenu hand: aHandMorph.

	self addPresentyMenuTo: aCustomMenu.
	
	aCustomMenu addLine.
	aCustomMenu add: 'set current language text' translated action: #setCurrentTranslation.	
]

{ #category : #menu }
PtyStringMorph >> addFillStyleMenuItems: aMenu hand: aHand [
	"Add the items for changing the current fill style of the Morph"
	| menu |
	aMenu add: 'change font color...' translated target: self action: #changeFontColor.
	super addFillStyleMenuItems: aMenu hand: aHand
]

{ #category : #testing }
PtyStringMorph >> canHaveFillStyles [
	^true
]

{ #category : #menu }
PtyStringMorph >> changeFontColor [
	"Change the color of the receiver -- triggered, e.g. from a menu"

	UITheme current
		chooseColorIn: self
		title: 'Choose font color' translated
		color: self color
		for: [:newColor |
			self textColor: newColor]
]

{ #category : #accessing }
PtyStringMorph >> computePositionForCharAt: index [

	| f offset |
	f := self fontToUse.
	offset := f widthOfString: contents from: 1 to: index.
	
	^self position x + offset @ self position y
]
