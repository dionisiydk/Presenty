Class {
	#name : #PtyPresenter,
	#superclass : #Announcer,
	#instVars : [
		'parent',
		'model',
		'view',
		'guide',
		'style',
		'name',
		'context',
		'userActions'
	],
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtyPresenter class >> defaultPrototypeInstance [
	^self defaultView
]

{ #category : #accessing }
PtyPresenter class >> defaultView [
	self subclassResponsibility 
]

{ #category : #'instance creation' }
PtyPresenter class >> named: aString [

	^self new
		name: aString 
]

{ #category : #'instance creation' }
PtyPresenter class >> named: aString on: anObject [

	^(self on: anObject)
		name: aString 
]

{ #category : #'instance creation' }
PtyPresenter class >> named: aString withStyle: styleName [

	^self new
		name: aString;
		style: styleName 
]

{ #category : #'instance creation' }
PtyPresenter class >> on: anObject [
	^self new model: anObject 
]

{ #category : #'instance creation' }
PtyPresenter class >> on: anObject withStyle: aString [
	^self new
		model: anObject;
		style: aString
]

{ #category : #'instance creation' }
PtyPresenter class >> withStyle: aString [
	^self new style: aString
]

{ #category : #accessing }
PtyPresenter >> addUserAction: userActionSource [

	| newAction |
	newAction := userActionSource asUserAction.
	newAction presenter: self.
	userActions add: newAction.

	^ newAction
]

{ #category : #convertion }
PtyPresenter >> asScrollablePanel [
	^PtyScrollablePanelPresenter on: self
]

{ #category : #convertion }
PtyPresenter >> asUserRequestTask [ 
	^PtyUserRequestTask new 
		presenter: self
]

{ #category : #accessing }
PtyPresenter >> basePrototypeContexts [ 

	^{PtyPresenterPrototypeContext of: self. PtyTaskPrototypeContext of: self context task}
]

{ #category : #testing }
PtyPresenter >> canBePrototypeInContextOf: aPresenter [
	^true
]

{ #category : #private }
PtyPresenter >> connectUserActionsBy:  anUISettings [

	userActions do: [:each | each connectToPresenterBy: anUISettings]
]

{ #category : #accessing }
PtyPresenter >> context [
	^ context ifNil: [parent ifNotNil: [parent context]]
]

{ #category : #accessing }
PtyPresenter >> context: anObject [

	context ifNotNil: [^self].
	context := anObject
]

{ #category : #private }
PtyPresenter >> createViewBy: anUISettings [

	view := anUISettings appropriateViewFor: self.
	view ptyLoadResourcesBy: guide.
	view translateSubViewsBy: guide.

]

{ #category : #presentation }
PtyPresenter >> createViewItems [
]

{ #category : #accessing }
PtyPresenter >> defaultPrototypeGroupName [ 
	^self class name
]

{ #category : #accessing }
PtyPresenter >> defaultView [
	^self class defaultView 
]

{ #category : #accessing }
PtyPresenter >> findParentWithStyle [
	parent ifNil: [^nil].
	
	parent hasStyle ifTrue: [^parent].
	
	^parent findParentWithStyle 
]

{ #category : #accessing }
PtyPresenter >> guide [
	^ guide
]

{ #category : #accessing }
PtyPresenter >> guide: anObject [
	guide := anObject
]

{ #category : #testing }
PtyPresenter >> hasStyle [
	^style notNil
]

{ #category : #private }
PtyPresenter >> hookupModel [
]

{ #category : #accessing }
PtyPresenter >> indexOfItem: aPresenter [

	parent ifNil: [^0].
	
	^parent indexOfItem: self 
]

{ #category : #'initialize-release' }
PtyPresenter >> initialize [ 
	super initialize.
	
	userActions := OrderedCollection new
]

{ #category : #accessing }
PtyPresenter >> model [
	^ model
]

{ #category : #accessing }
PtyPresenter >> model: anObject [
	model := anObject
]

{ #category : #accessing }
PtyPresenter >> name [
	^ name
]

{ #category : #accessing }
PtyPresenter >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PtyPresenter >> parent [
	^ parent
]

{ #category : #accessing }
PtyPresenter >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
PtyPresenter >> parentsChain [
	| parents presenter |
	parents := OrderedCollection new.
	presenter := self.
	[(presenter := presenter parent) notNil] whileTrue: [parents add: presenter].
	^parents
]

{ #category : #printing }
PtyPresenter >> printOn: aStream [

	super printOn: aStream.
	name ifNotNil: [
		aStream 
			nextPut: $(;
			nextPutAll: name;
			nextPut: $)		
		]
]

{ #category : #accessing }
PtyPresenter >> prototypeContextName [ 

	^name ifNil: [self defaultPrototypeGroupName]
]

{ #category : #accessing }
PtyPresenter >> prototypeStyleContextName [ 

	^self prototypeContextName, '(', style, ')' 
]

{ #category : #presentation }
PtyPresenter >> showItem: itemPresenter [
	^self showItem: itemPresenter onPanel: view	
]

{ #category : #presentation }
PtyPresenter >> showItem: itemPresenter on: panelName [
	(panelName isKindOf: String) ifFalse: [self error: 'panel name should be string'].

	self showItem: itemPresenter onPanel: (view panelNamed: panelName)
]

{ #category : #presentation }
PtyPresenter >> showItem: itemPresenter onPanel: panel [
	itemPresenter parent: self.
	guide preparePresenter: itemPresenter.
	panel add: itemPresenter view
]

{ #category : #presentation }
PtyPresenter >> showViewItems [
	self subclassResponsibility 
]

{ #category : #accessing }
PtyPresenter >> style [
	^ style
]

{ #category : #accessing }
PtyPresenter >> style: anObject [
	style := anObject
]

{ #category : #private }
PtyPresenter >> unhookModel [
]

{ #category : #accessing }
PtyPresenter >> userActions [
	^ userActions
]

{ #category : #accessing }
PtyPresenter >> userActions: anObject [
	userActions := anObject
]

{ #category : #accessing }
PtyPresenter >> view [
	^ view
]

{ #category : #accessing }
PtyPresenter >> view: anObject [
	view := anObject
]
