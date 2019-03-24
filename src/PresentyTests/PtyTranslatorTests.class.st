Class {
	#name : #PtyTranslatorTests,
	#superclass : #TestCase,
	#instVars : [
		'translator'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyTranslatorTests >> setUp [
	super setUp.
	translator := PtyTranslator new
]

{ #category : #tests }
PtyTranslatorTests >> testAddingExistedLanguage [
	
	| actual |
	translator languages add: (PtyLanguage named: 'lang').
	
	actual := translator addLanguage: 'lang'.
	
	translator languages should haveSize: 1.
	actual should beInstanceOf: PtyLanguage.
	actual name should equal: 'lang' 
]

{ #category : #tests }
PtyTranslatorTests >> testAddingNewLanguage [
	
	translator addLanguage: 'lang'.
	
	translator languages first should beInstanceOf: PtyLanguage.
	translator languages first name should be: 'lang'.
]

{ #category : #tests }
PtyTranslatorTests >> testAddingTranslationForExistedLanguage [
	
	| language |
	language := PtyLanguage named: 'lang'.
	translator currentLanguage: language.
	
	translator addTranslation: 'translated' for: 'text'.
	translator addTranslation: 'newTranslation' for: 'text'.
	
	(translator dictionary at: 'text') should not include: 'translated'.
	(translator dictionary at: 'text') should include: 'newTranslation'.
]

{ #category : #tests }
PtyTranslatorTests >> testAddingTranslationForNewLanguage [
	
	| language |
	language := PtyLanguage named: 'lang'.
	translator currentLanguage: language.
	translator addTranslation: 'translated' for: 'text'.
	
	((translator dictionary at: 'text') at: 'lang') should equal: 'translated'.
]

{ #category : #tests }
PtyTranslatorTests >> testAddingTranslationForSecondLanguage [
	
	| language language2 |
	language := PtyLanguage named: 'lang1'.
	language2 := PtyLanguage named: 'lang2'.

	translator currentLanguage: language2.	
	translator addTranslation: 'translation2' for: 'text'.
	
	translator currentLanguage: language.	
	translator addTranslation: 'translation' for: 'text'.
	
	((translator dictionary at: 'text') at: 'lang2') should equal: 'translation2'.
	((translator dictionary at: 'text') at: 'lang1') should equal: 'translation'.
]

{ #category : #tests }
PtyTranslatorTests >> testGettingPreferredKeyboard [

	[:lang | 
		translator currentLanguage: lang.
		
		[translator preferredKeyboard should be: #keyboard]
			should strictly satisfy: 
		[lang keyboard willReturn: #keyboard].

	] runWithMocks 
]

{ #category : #tests }
PtyTranslatorTests >> testGettingPreferredKeyboardWhenNoCurrentLanguage [

	| actual |
	translator currentLanguage: nil.
	
	actual := translator preferredKeyboard.
	
	actual should beInstanceOf: PtyKeyboardLayout.
	actual name should equal: PtyKeyboardLayout english name
]

{ #category : #tests }
PtyTranslatorTests >> testHasDictionaryByDefault [
	
	translator dictionary should be isEmpty
]

{ #category : #tests }
PtyTranslatorTests >> testHasNoLanguagesByDefault [
	
	translator languages should be isEmpty
]

{ #category : #tests }
PtyTranslatorTests >> testHasSingleKeybordByDefault [
	
	translator keyboards should haveSize: 1.
	translator keyboards first name should equal: PtyKeyboardLayout english name
]
