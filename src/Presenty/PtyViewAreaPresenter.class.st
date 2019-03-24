Class {
	#name : #PtyViewAreaPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'items',
		'uiActions',
		'body'
	],
	#category : #'Presenty-Core'
}

{ #category : #presentation }
PtyViewAreaPresenter >> activateBy: aViewAreaActivator [

	aViewAreaActivator hasPreparedViewport
		ifFalse: [aViewAreaActivator prepareViewportBy: guide].
		
	aViewAreaActivator activateViewportBy: guide.
	
	aViewAreaActivator show: self by: guide
]

{ #category : #accessing }
PtyViewAreaPresenter >> add: aPresenter on: panelName [
	
	items add: (PtyViewAreaItem presenter: aPresenter on: panelName)
	
]

{ #category : #accessing }
PtyViewAreaPresenter >> addBody: aPresenter [
	
	body := PtyViewAreaItem bodyWith: aPresenter
	
]

{ #category : #accessing }
PtyViewAreaPresenter >> addUIAction: uiActionBlock [

	uiActions add: uiActionBlock 
]

{ #category : #presentation }
PtyViewAreaPresenter >> applyUIActions [
	uiActions do: [ :each | each value ]
]

{ #category : #accessing }
PtyViewAreaPresenter >> body [
	^ body
]

{ #category : #accessing }
PtyViewAreaPresenter >> body: anObject [
	body := anObject
]

{ #category : #accessing }
PtyViewAreaPresenter >> createCopy [
	| area |
	area := PtyViewAreaPresenter new.
	area name: name.
	area parent: parent.
	area guide: guide.
	area uiActions: uiActions copy.
	area userActions: (userActions collect: [:each | 
		each copy presenter: area; connectorPrototype: nil; yourself]).
	area items: items copy.
	area body: body.
	^ area
]

{ #category : #'initialize-release' }
PtyViewAreaPresenter >> initialize [ 
	super initialize.
	
	items := OrderedCollection new.
	uiActions := OrderedCollection new
]

{ #category : #accessing }
PtyViewAreaPresenter >> items [
	^ items
]

{ #category : #accessing }
PtyViewAreaPresenter >> items: anObject [
	items := anObject
]

{ #category : #accessing }
PtyViewAreaPresenter >> separateForkItemsOn: aViewArea [

	| commonTask forkItem |

	body ifNil: [^self].
		
	forkItem := items reversed detect: [:each | each presenter class = PtyViewAreaPresenter] 
		ifNone: [^self].

	commonTask := guide context task findCommonParentWith: forkItem presenter context task. 
	commonTask activationStrategy allowSeparateItems ifFalse: [^self].
	
	aViewArea body: body.
	
	body := nil.
		

]

{ #category : #accessing }
PtyViewAreaPresenter >> setUpItemsContext: aTaskContext [

	items do: [:each | each presenter context: aTaskContext].
	body ifNil: [^self].
	body presenter context: aTaskContext
]

{ #category : #presentation }
PtyViewAreaPresenter >> showViewItems [
	items do: [ :each | each showOn: view by: guide ].
	body ifNotNil: [ body showOn: view by: guide ].
	self applyUIActions.

]

{ #category : #accessing }
PtyViewAreaPresenter >> uiActions [
	^ uiActions
]

{ #category : #accessing }
PtyViewAreaPresenter >> uiActions: anObject [
	uiActions := anObject
]
