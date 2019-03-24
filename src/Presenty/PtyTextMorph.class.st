Class {
	#name : #PtyTextMorph,
	#superclass : #TextMorph,
	#instVars : [
		'textAlignment'
	],
	#category : #'Presenty-UI'
}

{ #category : #menu }
PtyTextMorph >> addCustomMenuItems: aCustomMenu hand: aHandMorph [

	super addCustomMenuItems: aCustomMenu hand: aHandMorph.
	
	self addPresentyMenuTo: aCustomMenu
]

{ #category : #menu }
PtyTextMorph >> addFillStyleMenuItems: aMenu hand: aHand [
	"Add the items for changing the current fill style of the Morph"
	| menu |
	aMenu add: 'change font color...' translated target: self action: #changeFontColor.
	super addFillStyleMenuItems: aMenu hand: aHand
]

{ #category : #testing }
PtyTextMorph >> canHaveFillStyles [
	^true
]

{ #category : #'changing font' }
PtyTextMorph >> changeEmphasisOrAlignment [
	| aList reply code align menuList startIndex alignSymbol |

	startIndex := self editor startIndex.
	aList := #(#normal #bold #italic #narrow #underlined #struckOut #leftFlush #centered #rightFlush #justified ).
	align := paragraph text
				alignmentAt: startIndex
				ifAbsent: [paragraph textStyle alignment].
	alignSymbol := TextAlignment alignmentSymbol: align.
	code := paragraph text emphasisAt: startIndex.
	menuList := Array new writeStream.
	menuList nextPut: (code isZero
			ifTrue: ['<on>']
			ifFalse: ['<off>'])
			, 'normal' translated.
	menuList
		nextPutAll: (#(#bold #italic #underlined #struckOut )
				collect: [:emph | (code anyMask: (TextEmphasis perform: emph) emphasisCode)
						ifTrue: ['<on>' , emph asString translated]
						ifFalse: ['<off>' , emph asString translated]]).
	((paragraph text attributesAt: startIndex forStyle: paragraph textStyle)
			anySatisfy: [:attr | attr isKern
					and: [attr kern < 0]])
		ifTrue: [menuList nextPut: '<on>' , 'narrow' translated]
		ifFalse: [menuList nextPut: '<off>' , 'narrow' translated].
	menuList
		nextPutAll: (#(#leftFlush #centered #rightFlush #justified )
				collect: [:type | type == alignSymbol
						ifTrue: ['<on>' , type asString translated]
						ifFalse: ['<off>' , type asString translated]]).
	aList := #(#normal #bold #italic #underlined #struckOut #narrow #leftFlush #centered #rightFlush #justified ).
	reply := UIManager default chooseFrom: menuList contents values: aList lines: #(1 6 ).
	reply ifNotNil: [
		(#(#leftFlush #centered #rightFlush #justified ) includes: reply)
				ifTrue: [self editor setAlignment: reply.
					self editor paragraph composeAll.
					self editor recomputeInterval]
				ifFalse: [self editor setEmphasis: reply.
					self editor paragraph composeAll.
					self editor recomputeSelection]].
	^ true
]

{ #category : #menu }
PtyTextMorph >> changeFontColor [
	"Change the color of the receiver -- triggered, e.g. from a menu"

	UITheme current
		chooseColorIn: self
		title: 'Choose font color' translated
		color: self color
		for: [:newColor |
			self textColor: newColor]
]

{ #category : #'changing font' }
PtyTextMorph >> changeFontFor: aFont [
	self font: aFont.
	self changed
]

{ #category : #'changing font' }
PtyTextMorph >> chooseEmphasisOrAlignment [
	| aList reply  code align menuList startIndex attribute |
	startIndex := self editor startIndex.
	align := self text alignmentAt: startIndex ifAbsent: [ 0 ].
	code := self text emphasisAt: startIndex.
	menuList := WriteStream on: Array new.
	menuList nextPut: (code isZero -> 'normal' translated).
	menuList nextPutAll: (#(bold italic underlined struckOut) collect: [:emph|
		(code anyMask: (TextEmphasis perform: emph) emphasisCode) -> emph asString translated]).
	
	menuList nextPut: ((self text attributesAt: startIndex)
		anySatisfy: [ :attr | attr isKern and: [attr kern < 0 ]]) -> 'narrow' translated.
		
	self editor alignmentChoices collectWithIndex: [ :type :i |
		menuList nextPut: (align = (i-1)) -> type asString translated ].
	
	aList := #(normal bold italic underlined struckOut narrow leftFlush centered rightFlush justified).
	reply := UIManager default chooseFrom:  aList values: aList.
	textAlignment := reply.
	reply notNil ifTrue: [
		(self editor alignmentChoices includes: reply)
			ifTrue: [ attribute :=TextAlignment perform: reply]
			ifFalse: [ attribute := TextEmphasis perform: reply].
		self editor applyAttribute:  attribute].
	self updateFromParagraph.

]

{ #category : #'changing font' }
PtyTextMorph >> chooseFont [
	| startIndex curFont |
	self requestFontFromUser.
	self updateFromParagraph.
	
	startIndex := self editor startIndex.
	
	curFont := (self paragraph text fontAt: startIndex withStyle: self paragraph textStyle).
	self font: curFont

	
]

{ #category : #drawing }
PtyTextMorph >> drawKeyboardFocusOn: aCanvas [	
]

{ #category : #initialize }
PtyTextMorph >> initialize [
	super initialize.
	textAlignment := #centered
]

{ #category : #accessing }
PtyTextMorph >> newContents: aString [

	super newContents: aString.
	self updateTextColor

]

{ #category : #'changing font' }
PtyTextMorph >> requestFontFromUser [
	"Present a dialog which allows the user to select a font, and if one is chosen, apply it to the current selection.	If there is no selection, or the selection is empty, apply it to the whole morph."
		
	"?? Should the dialog allow the user to select a bold/italic/black font.
	Or just the most regular member of a Font Family?"
	| curFont startIndex chooser newFont |
	startIndex := self editor startIndex.
	"stopIndex := self stopIndex-1 min: paragraph text size."
	curFont := (paragraph text fontAt: startIndex withStyle: paragraph textStyle).
	(curFont isKindOf: LogicalFont)
		ifTrue:[
			curFont := curFont copy.
			((paragraph text emphasisAt: startIndex) anyMask: 1) ifTrue:[curFont forceBold].
			((paragraph text emphasisAt: startIndex) anyMask: 2) ifTrue:[curFont forceItalicOrOblique].
			curFont clearRealFont].
	chooser := self openModal: (
		Cursor wait showWhile: [ 
			FontChooser 
				windowTitle: 'Change the selected text''s font to...' translated
				for: self 
				setSelector: #changeFontFor:
				getSelector: curFont]).
	newFont := chooser result.
	newFont ifNotNil: [^self font: newFont].
	self font: curFont 
	
]

{ #category : #private }
PtyTextMorph >> updateTextColor [
	text addAttribute: (TextColor color: self textColor).
	self changed
]
