Class {
	#name : #PtyKeyboardPresenter,
	#superclass : #PtyInputToolPresenter,
	#instVars : [
		'upperCharsButton',
		'languageButton',
		'letters',
		'uppercaseMode',
		'symbolsButton',
		'symbolsMode'
	],
	#category : #'Presenty-ScreenTools'
}

{ #category : #presentation }
PtyKeyboardPresenter >> createKeyboardRowOn: panel [

	^self showItem: (PtyPresentersDecorator on: #() withStyle: #keyboardRow) onPanel: panel
		
]

{ #category : #'initialize-release' }
PtyKeyboardPresenter >> initialize [
	
	super initialize.
	
	uppercaseMode := false.
	symbolsMode := false
]

{ #category : #accessing }
PtyKeyboardPresenter >> languageButtonLabel [

	| otherKeyboards |
	otherKeyboards := guide translator keyboards reject: [:each | each name = letters name].
	otherKeyboards size = 1 ifTrue: [^otherKeyboards first name].
	
	^'Another language'
]

{ #category : #presentation }
PtyKeyboardPresenter >> showDigits [
	
	| button rowContainer |
	rowContainer := view panelNamed: 'digits'.
	
	'1234567890' do: [ :each | 			
			 
			button := self buttonForChar: each withStyle: #keyboardDigitButton.
				
			self showItem: button onPanel: rowContainer].
	
	
]

{ #category : #presentation }
PtyKeyboardPresenter >> showLetters [
	| lettersContainer button rowContainer currentLayout |
	
	symbolsMode := false.
	
	self updateSymbolsButton.	
	
	lettersContainer := view panelNamed: 'letters'.
	lettersContainer clear.

	currentLayout := uppercaseMode ifTrue: [letters uppercaseLayout] ifFalse: [letters lettersLayout].
	currentLayout
		do: [ :eachRow | 
			rowContainer := self createKeyboardRowOn: lettersContainer.
			eachRow
				do: [ :each | 
					button := self buttonForChar: each withStyle: #keyboardButton.
					self showItem: button onPanel: rowContainer ]
		 ].

]

{ #category : #presentation }
PtyKeyboardPresenter >> showSpecialButtons [
	| deleteAllButton deleteLastButton space rowContainer specialPanel |
	
	specialPanel := view panelNamed: 'special'.
	
	rowContainer := self createKeyboardRowOn: specialPanel.
	
	space := self buttonForChar: $ withStyle: #spaceKeyboardButton.
	space actionName: nil.
	self showItem: space onPanel: rowContainer.
	
	deleteLastButton := self backspaceButtonWithStyle: #keyboardDeleteButton.
	self showItem: deleteLastButton onPanel: rowContainer.
	
	deleteAllButton := self clearButtonWithStyle: #keyboardDeleteAllButton.
	self showItem: deleteAllButton onPanel: rowContainer.
	
	rowContainer := self createKeyboardRowOn: specialPanel.	
					
	upperCharsButton := PtyPresentersDecorator named: 'Uppercase mode' withStyle: #caseModeButton.
	upperCharsButton addUserAction: [self toggleUppercase].
	self showItem: upperCharsButton onPanel: rowContainer.
	
	guide translator keyboards size >= 2 ifTrue: [
	
		languageButton := PtyPresentersDecorator named: self languageButtonLabel withStyle: 			#keyboardLanguageButton.
		languageButton addUserAction: [self toggleLanguage].	
	
		self showItem: languageButton onPanel: rowContainer].
	
	symbolsButton := PtyPresentersDecorator named: 'Symbols mode' withStyle: #symbolsModeButton.
	symbolsButton addUserAction: [self toggleSymbols].
	self showItem: symbolsButton onPanel: rowContainer.
]

{ #category : #presentation }
PtyKeyboardPresenter >> showSymbols [
	| lettersContainer button rowContainer |
	
	symbolsMode :=true.
	
	self updateSymbolsButton.
		
	lettersContainer := view panelNamed: 'letters'.
	lettersContainer clear.

	letters symbolsLayout
		do: [ :eachRow | 
			rowContainer := self createKeyboardRowOn: lettersContainer.
			eachRow
				do: [ :each | 
					button := self buttonForChar: each withStyle: #keyboardButton.
					self showItem: button onPanel: rowContainer ]
		 ].

]

{ #category : #presentation }
PtyKeyboardPresenter >> showViewItems [

	letters := guide translator preferredKeyboard.
	self showDigits.
	self showLetters.
	self showSpecialButtons
]

{ #category : #presentation }
PtyKeyboardPresenter >> toggleLanguage [

	| otherKeyboards |
	languageButton label: letters name.
	
	otherKeyboards := guide translator keyboards reject: [:each | each name = letters name].
	
	letters := otherKeyboards anyOne.
	
	self showLetters  
]

{ #category : #presentation }
PtyKeyboardPresenter >> toggleLetters [

	self updateSymbolsButton.
			
	self showLetters
]

{ #category : #presentation }
PtyKeyboardPresenter >> toggleSymbols [

	symbolsMode
		ifFalse: [self showSymbols] 
		ifTrue: [self showLetters].			

]

{ #category : #presentation }
PtyKeyboardPresenter >> toggleUppercase [

	uppercaseMode := uppercaseMode not.
	
	uppercaseMode ifTrue: [
		upperCharsButton label: 'Lowcase mode'] 
			ifFalse: [upperCharsButton label: 'Uppercase mode'].
			
	self showLetters
]

{ #category : #presentation }
PtyKeyboardPresenter >> updateSymbolsButton [
	symbolsButton ifNil: [^self].
	
	symbolsMode 
		ifTrue: [symbolsButton label: 'Letters mode'] 
		ifFalse: [symbolsButton label: 'Symbols mode'].			

]
