Class {
	#name : #PtyLanguagesSelectionPresenter,
	#superclass : #PtyCompositePresenter,
	#category : #'Presenty-Presenters'
}

{ #category : #presentation }
PtyLanguagesSelectionPresenter >> setLanguage: anLanguage [

	guide useLanguage: anLanguage 
]

{ #category : #presentation }
PtyLanguagesSelectionPresenter >> showViewItems [ 

	| button presenter |
	guide translator languages size < 2 ifTrue: [^self].	
	
	guide translator languages do: [:each |
		
		presenter := PtyLanguagePresenter on: each.
		presenter addUserAction: [self setLanguage: each].
		
		self showItem: presenter
		
		]
]
