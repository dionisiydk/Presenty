Class {
	#name : #PtyPresenterStylePrototypeContext,
	#superclass : #PtyNamedPrototypeContext,
	#category : #'Presenty-Core'
}

{ #category : #'instance creation' }
PtyPresenterStylePrototypeContext class >> basedOn: aPresenter [

	^self named: aPresenter style 
]

{ #category : #testing }
PtyPresenterStylePrototypeContext class >> isActiveFor: anObject [

	(anObject isKindOf: PtyPresenter) ifFalse: [^false].

	^anObject hasStyle  
]
