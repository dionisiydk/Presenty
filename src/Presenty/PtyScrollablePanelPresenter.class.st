Class {
	#name : #PtyScrollablePanelPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'scroller',
		'verticalBar',
		'horizontalBar',
		'minSliderExtent',
		'scrollDelta'
	],
	#category : #'Presenty-Presenters'
}

{ #category : #presentation }
PtyScrollablePanelPresenter >> createViewItems [ 

	scroller := TransformMorph new.
	scroller 
		color: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	
	verticalBar := PtyScrollBarPresenter on: self withStyle: #verticalScrollBar.
	horizontalBar := PtyScrollBarPresenter on: self withStyle: #horizontalScrollBar.
	
	
]

{ #category : #'initialize-release' }
PtyScrollablePanelPresenter >> initialize [ 
	super initialize.
	
	minSliderExtent := 10@10.
	scrollDelta := 0.02
]

{ #category : #presentation }
PtyScrollablePanelPresenter >> scrollByDelta: aPoint [ 

	scroller offset: model view extent * aPoint
]

{ #category : #presentation }
PtyScrollablePanelPresenter >> scrollByWheel: event [

	| wheelDelta |
	event direction = #up ifTrue: [wheelDelta := -1 * scrollDelta].
	event direction = #down ifTrue: [wheelDelta := scrollDelta].

	verticalBar scrollByStep: 0 @ wheelDelta


]

{ #category : #computing }
PtyScrollablePanelPresenter >> scrollerExtent [
	^scroller extent
]

{ #category : #presentation }
PtyScrollablePanelPresenter >> showViewItems [ 

	(view panelNamed: 'scrollableBody') 
		clear;
		add: scroller.	
	
	scroller removeAllMorphs.
	self showItem: model onPanel: scroller.
	model view position: 0@0.
	scroller extent: (view panelNamed: 'scrollableBody') extent.	
	
	verticalBar view 
		ifNil: [self showItem: verticalBar on: 'verticalBar']
		ifNotNil: [(view panelNamed: 'verticalBar') add: verticalBar view].
	horizontalBar view 
		ifNil: [self showItem: horizontalBar on: 'horizontalBar']
		ifNotNil: [(view panelNamed: 'horizontalBar') add: horizontalBar view].
			
	self updateBarsVisibility.

	view on: #mouseWheel send: #scrollByWheel: to: self.
	view announcer on: PtyLayoutChanged send: #update to: self.
	model view announcer on: PtyLayoutChanged send: #update to: self.
]

{ #category : #computing }
PtyScrollablePanelPresenter >> sliderSize [

	^(self scrollerExtent / model view extent * self scrollerExtent min: self scrollerExtent) max: minSliderExtent.
	
	
	
]

{ #category : #presentation }
PtyScrollablePanelPresenter >> unhookModel [

	model view ifNotNil: [:v | v announcer unsubscribe: self]
]

{ #category : #presentation }
PtyScrollablePanelPresenter >> update [
	scroller extent: (view panelNamed: 'scrollableBody') extent.
	
	verticalBar updateSlider.
	horizontalBar updateSlider.
	
	self updateBarsVisibility 
]

{ #category : #presentation }
PtyScrollablePanelPresenter >> updateBarsVisibility [

	| sliderSize |
	sliderSize := self sliderSize.

	sliderSize y >= scroller height 
		ifTrue: [verticalBar view delete.
			(view panelNamed: 'verticalBar') width: 0]
		ifFalse: [(view panelNamed: 'verticalBar') add: verticalBar view].
		
	sliderSize x >= scroller width 
		ifTrue: [horizontalBar view delete.
			(view panelNamed: 'horizontalBar') height: 0]
		ifFalse: [(view panelNamed: 'horizontalBar') add: horizontalBar view].
]
