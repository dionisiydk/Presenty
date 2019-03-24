Class {
	#name : #PtyScrollableListDecorator,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'nextButton',
		'prevButton',
		'visibleItems',
		'visibleNextItems',
		'visiblePrevItems',
		'buttonsBar'
	],
	#category : #'Presenty-Presenters'
}

{ #category : #private }
PtyScrollableListDecorator >> addButton: aButton forNextItemsFor: aPanel [

	| flow |
	flow := aPanel ptyFlowBounds.

	self showItem: aButton onPanel: aPanel.
	aPanel doLayoutIn: aPanel bounds.

	[visiblePrevItems isEmpty or: [flow containsFullMorph: aButton view]] whileFalse: [
		visiblePrevItems first view delete.
		visiblePrevItems removeFirst.
		visibleItems removeFirst.
		aPanel doLayoutIn: aPanel bounds.
	].

	[visibleNextItems isEmpty or: [flow containsFullMorph: aButton view]] whileFalse: [
		visibleNextItems last view delete.
		visibleNextItems removeLast.
		visibleItems removeLast.
		aPanel doLayoutIn: aPanel bounds.
	].


]

{ #category : #private }
PtyScrollableListDecorator >> addButton: aButton forPrevItemsFor: aPanel [

	| flow |
	flow := aPanel ptyFlowBounds.

	self showItem: aButton onPanel: aPanel.
	aPanel doLayoutIn: aPanel bounds.


	[visibleNextItems isEmpty or: [flow containsFullMorph: aButton view]] whileFalse: [
		visibleNextItems last view delete.
		visibleNextItems removeLast.
		visibleItems removeLast.
		aPanel doLayoutIn: aPanel bounds.
	].

	[visiblePrevItems isEmpty or: [flow containsFullMorph: aButton view]] whileFalse: [
		visiblePrevItems first view delete.
		visiblePrevItems removeFirst.
		visibleItems removeFirst.
		aPanel doLayoutIn: aPanel bounds.
	].



]

{ #category : #private }
PtyScrollableListDecorator >> addNextItemsButtonBarFor: aPanel [

	| buttons |
	buttons := OrderedCollection new.

	visibleItems ifEmpty: [^self].
	visibleItems first == model first ifFalse: [
		buttons add: prevButton].
	
	visibleItems last == model last ifFalse: [
		buttons add: nextButton].
	
	buttons ifEmpty: [^self].
	
	buttonsBar model: buttons.		
	self addButton: buttonsBar forNextItemsFor: aPanel.
	visibleItems addLast: buttonsBar.
]

{ #category : #private }
PtyScrollableListDecorator >> addNextItemsButtonsFor: aPanel [

	visibleItems first == model first ifFalse: [
		self addButton: prevButton forNextItemsFor: aPanel.
		visibleItems addFirst: prevButton].

	visibleItems last == model last ifFalse: [
		self addButton: nextButton forNextItemsFor: aPanel.
		visibleItems addLast: nextButton].
]

{ #category : #private }
PtyScrollableListDecorator >> addPrevItemsButtonBarFor: aPanel [

	| buttons |
	buttons := OrderedCollection new.

	visibleItems first == model first ifFalse: [
		buttons add: prevButton].
	
	visibleItems last == model last ifFalse: [
		buttons add: nextButton].
	
	buttons ifEmpty: [^self].
	
	buttonsBar model: buttons.	
	self addButton: buttonsBar forPrevItemsFor: aPanel.
	visibleItems addLast: buttonsBar.
]

{ #category : #private }
PtyScrollableListDecorator >> addPrevItemsButtonsFor: aPanel [

	visibleItems last == model last ifFalse: [
		self addButton: nextButton forPrevItemsFor: aPanel.
		visibleItems addLast: nextButton].
	
	visibleItems first == model first ifFalse: [
		self addButton: prevButton forPrevItemsFor: aPanel.
		visibleItems addFirst: prevButton].

]

{ #category : #private }
PtyScrollableListDecorator >> collectVisibleNextItems: nextItems for: aPanel [

	| flow |

	flow := aPanel ptyFlowBounds.
	visibleNextItems := OrderedCollection new.
	
	nextItems do: [:each | 
		self showItem: each onPanel: aPanel.
		aPanel doLayoutIn: aPanel bounds.
		(flow containsFullMorph: each view) ifFalse: [
				^each view delete].
		visibleItems addLast: each.
		visibleNextItems addLast: each].
]

{ #category : #private }
PtyScrollableListDecorator >> collectVisiblePrevItems: prevItems for: aPanel [

	| flow |

	flow := aPanel ptyFlowBounds.
	visiblePrevItems := OrderedCollection new.
	
	prevItems reverseDo: [:each | 
		self showItem: each onPanel: aPanel.
		aPanel doLayoutIn: aPanel bounds.
		(flow containsFullMorph: each view) ifFalse: [
				^each view delete].
		visibleItems addFirst: each.
		visiblePrevItems addFirst: each]
	
	
	
	
]

{ #category : #presentation }
PtyScrollableListDecorator >> createViewItems [

	| helperPanel |

	super createViewItems.
	
	nextButton := PtyPresentersDecorator named: 'button' withStyle: #nextPageItems.
	nextButton addUserAction: [self showNextVisibleItems].		

	prevButton := PtyPresentersDecorator named: 'button' withStyle: #prevPageItems.
	prevButton addUserAction: [self showPrevVisibleItems].
	
	buttonsBar := PtyPresentersDecorator withStyle: #scrollableListButtons.
	
	visibleItems := OrderedCollection new.
	helperPanel := view shallowCopy.
	
	visiblePrevItems := OrderedCollection new.
	visiblePrevItems := OrderedCollection new.

	self collectVisibleNextItems: model for: helperPanel.
	self addNextItemsButtonBarFor: helperPanel

]

{ #category : #accessing }
PtyScrollableListDecorator >> firstVisibleItem [
	^visibleItems first 
]

{ #category : #presentation }
PtyScrollableListDecorator >> makeVisibleItem: itemPresenter [

	| helperPanel nextItems |

	(visibleItems includes: itemPresenter) ifTrue: [^self].

	view clear.
	helperPanel := view shallowCopy.		
	
	nextItems := (model copyAfter: itemPresenter) copyWithFirst: itemPresenter.
	visibleItems reset.

	self collectVisibleNextItems: nextItems for: helperPanel.
	self collectVisiblePrevItems: (model copyUpTo: visibleItems first) for: helperPanel.
	self addNextItemsButtonBarFor: helperPanel.
		
	self showViewItems
	
	
	
	
]

{ #category : #presentation }
PtyScrollableListDecorator >> showNextVisibleItems [

	| helperPanel nextItems |

	view clear.
	helperPanel := view shallowCopy.		
	
	nextItems := model copyAfter: visibleItems nextToLast.
	visibleItems reset.

	self collectVisibleNextItems: nextItems for: helperPanel.
	self collectVisiblePrevItems: (model copyUpTo: visibleItems first) for: helperPanel.
	self addNextItemsButtonBarFor: helperPanel.		
	self showViewItems.
	self announce: PtyListScrolled
	
	
	
	
]

{ #category : #presentation }
PtyScrollableListDecorator >> showPrevVisibleItems [

	| helperPanel prevItems |
	view clear.
	helperPanel := view shallowCopy.		
	
	prevItems := model copyUpTo: visibleItems second.
	visibleItems reset.

	self collectVisiblePrevItems: prevItems for: helperPanel.
	self collectVisibleNextItems: (model copyAfter: visibleItems last) for: helperPanel.
	self addPrevItemsButtonBarFor: helperPanel.
	
	self showViewItems.
	self announce: PtyListScrolled
	
	
	
]

{ #category : #presentation }
PtyScrollableListDecorator >> showViewItems [

	visibleItems do: [:each | 
		
		view add: each view
		
		].
	
	
	
	
]

{ #category : #accessing }
PtyScrollableListDecorator >> visibleItems [
	^ visibleItems
]

{ #category : #accessing }
PtyScrollableListDecorator >> visibleItems: anObject [
	visibleItems := anObject
]
