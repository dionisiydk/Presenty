Class {
	#name : #PtyButtonPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'titleContent'
	],
	#category : #'Presenty-Editor-Fields'
}

{ #category : #initialize }
PtyButtonPresenter >> initialize [
	super initialize.
	titleContent := {}
]

{ #category : #accessing }
PtyButtonPresenter >> model: anUserAction [
	| buttonAction |
	super model: anUserAction.
	buttonAction := anUserAction copy.
	buttonAction name: 'ButtonAction'.
	self addUserAction: buttonAction
]

{ #category : #presentation }
PtyButtonPresenter >> showViewItems [
	| title |
	title := PtyPresentersDecorator named: 'buttonTitle' withStyle: model prototypeContextName.
	title model: titleContent.
	self showItem: title
]

{ #category : #accessing }
PtyButtonPresenter >> titleContent: presenterCollection [
	titleContent := presenterCollection
]
