Extension { #name : #Object }

{ #category : #'*Presenty-Presenters' }
Object >> preferredPreviewPresenter [
	^PtyLabelPresenter textNamed: self asString withStyle: #objectPreview
]

{ #category : #'*Presenty-Editor-Fields' }
Object >> previewPresenterForFieldWith: aFieldDesc [

	^PtySimpleLabelPresenter on: (aFieldDesc printFieldValue: self) withStyle: #fieldValue
]

{ #category : #'*Presenty-Tasks' }
Object >> ptyAspect: anArray [
	^PtyObjectAspect of: self path: anArray 
]

{ #category : #'*Presenty-ItemSelectionTask' }
Object >> ptyUserSearchField [
	^self asString
]
