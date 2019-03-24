Class {
	#name : #PtyScrollBarPresenter,
	#superclass : #PtyCompositePresenter,
	#instVars : [
		'slider',
		'moveBar'
	],
	#category : #'Presenty-Presenters'
}

{ #category : #'events handling' }
PtyScrollBarPresenter >> scrollAbsolute: event [
	
	| newPosition delta |
	event redButtonPressed ifFalse: [^self].

	view ptyFlowBounds move: slider view direction: event direction.
	
	newPosition := slider view position.
	
	delta := newPosition - view position /  view ptyFlowBounds bounds extent.
	
	model scrollByDelta: delta
	
	
	
	
]

{ #category : #'events handling' }
PtyScrollBarPresenter >> scrollByStep: stepPoint [
	
	| newPosition currentDelta newDelta |

	currentDelta := slider view position - view position /  view ptyFlowBounds bounds extent.
	newDelta := currentDelta + stepPoint.
	newDelta := newDelta 
					min: (view extent - slider view extent /  view ptyFlowBounds bounds extent) 
					max: 0@0.

	newPosition := newDelta * view ptyFlowBounds bounds extent + view position.

	slider view position: newPosition.

	model scrollByDelta: newDelta
	
	
	
	
]

{ #category : #presentation }
PtyScrollBarPresenter >> showViewItems [ 

	slider := PtyPresentersDecorator withStyle: #scrollBarSlider.
	
	self showItem: slider.
	
	self updateSlider.
	
	slider view 
		disableTableLayout: true;
		position: view position;		
		on: #mouseDown send: #yourself to: self;
		on: #mouseMove send: #scrollAbsolute: to: self.

		
]

{ #category : #presentation }
PtyScrollBarPresenter >> updateSlider [ 

	view ptyFlowBounds setSize: model sliderSize for: slider view.

]
