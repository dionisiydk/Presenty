Class {
	#name : #PtyVisualToolTestCase,
	#superclass : #PtyToolTestCase,
	#category : #'Presenty-Tests-Tools'
}

{ #category : #testing }
PtyVisualToolTestCase class >> isAbstract [ 
	^self = PtyVisualToolTestCase
]

{ #category : #tests }
PtyVisualToolTestCase >> testActivationOnPanel [
	| view settings |
	settings := Mock new.
	targetTask stub settings willReturn: settings.
	view := Mock new.
	(settings stub preferredViewFor: tool) willReturn: view.
	
	tool activateOnPanel.
	
	panel should receive placeView: view
]

{ #category : #tests }
PtyVisualToolTestCase >> testDefinesDefaultView [

	| settings view |
	settings := PtySettings new.
	
	view := settings preferredViewFor: tool.
	
	view should not be: nil
]
