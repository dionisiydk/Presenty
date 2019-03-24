Class {
	#name : #PtyTranslator,
	#superclass : #Object,
	#instVars : [
		'dictionary',
		'languages',
		'currentLanguage',
		'keyboards'
	],
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtyTranslator >> addLanguage: langName [ 

	^languages detect: [:each | each name = langName]
		ifNone: [languages add: (PtyLanguage named: langName)]
]

{ #category : #accessing }
PtyTranslator >> addTranslation: translatedString for: sourceString [

	| translations |
	translations := dictionary at: sourceString ifAbsentPut: [Dictionary new].
	translations at: currentLanguage name put: translatedString
]

{ #category : #accessing }
PtyTranslator >> currentLanguage [
	^ currentLanguage
]

{ #category : #accessing }
PtyTranslator >> currentLanguage: anObject [
	currentLanguage := anObject
]

{ #category : #accessing }
PtyTranslator >> dictionary [
	^ dictionary
]

{ #category : #accessing }
PtyTranslator >> dictionary: anObject [
	dictionary := anObject
]

{ #category : #'initialize-release' }
PtyTranslator >> initialize [ 
	super initialize.
	dictionary := Dictionary new.
	languages := OrderedCollection new.
	keyboards := OrderedCollection with: PtyKeyboardLayout english
]

{ #category : #accessing }
PtyTranslator >> keyboards [
	^ keyboards
]

{ #category : #accessing }
PtyTranslator >> keyboards: anObject [
	keyboards := anObject
]

{ #category : #accessing }
PtyTranslator >> languages [
	^ languages
]

{ #category : #accessing }
PtyTranslator >> languages: anObject [
	languages := anObject
]

{ #category : #accessing }
PtyTranslator >> preferredKeyboard [

	currentLanguage ifNil: [^PtyKeyboardLayout english].
	^currentLanguage keyboard
]

{ #category : #translation }
PtyTranslator >> translate: aString [

	| translations |
	translations := dictionary at: aString ifAbsent: [^aString].
	
	translations ifEmpty: [^aString].
	
	currentLanguage ifNil: [^aString].
	
	^translations 
		at: currentLanguage name
		ifAbsent: [aString]
]
