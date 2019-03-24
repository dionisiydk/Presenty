Class {
	#name : #PtyGettingTranslationTests,
	#superclass : #TestCase,
	#instVars : [
		'translator',
		'someLanguage',
		'targetLanguage'
	],
	#category : #'PresentyTests-Core'
}

{ #category : #running }
PtyGettingTranslationTests >> setUp [
	super setUp.
	translator := PtyTranslator new.
	
	someLanguage := PtyLanguage named: 'someLang'.
	targetLanguage := PtyLanguage named: 'targetLang'.
	
	translator currentLanguage: someLanguage.
	translator addTranslation: 'someTranslation' for: 'text'.
	
	translator currentLanguage: targetLanguage
]

{ #category : #tests }
PtyGettingTranslationTests >> testWhenCurrentLanguageExistsAndTranslationExistsForIt [

	| actual |
	translator currentLanguage: targetLanguage.
	translator addTranslation: 'translation' for: 'text'.
		
	actual := translator translate: 'text'.
	
	actual should equal: 'translation'
]

{ #category : #tests }
PtyGettingTranslationTests >> testWhenCurrentLanguageExistsButTextAbsentInDictionary [

	| actual |
	actual := translator translate: 'absentText'.
	
	actual should equal: 'absentText'
]

{ #category : #tests }
PtyGettingTranslationTests >> testWhenCurrentLanguageExistsButTranslationAbsentForIt [

	| actual |
	actual := translator translate: 'text'.
	
	actual should equal: 'text'
]

{ #category : #tests }
PtyGettingTranslationTests >> testWhenDictionaryEmpty [

	| actual |
	translator dictionary removeAll.
	
	actual := translator translate: 'text'.
	
	actual should equal: 'text'
]

{ #category : #tests }
PtyGettingTranslationTests >> testWhenNoCurrentLanguageAndNoTranslation [

	| actual |
	
	translator currentLanguage: nil.
	(translator dictionary at: 'text' ) removeAll.
	
	actual := translator translate: 'text'.
	
	actual should equal: 'text'
]

{ #category : #tests }
PtyGettingTranslationTests >> testWhenNoCurrentLanguageButTranslationExists [

	| actual |
	translator currentLanguage: nil.
		
	actual := translator translate: 'text'.
	
	actual should equal: 'text'
]
