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
PtyVisualToolTestCase >> testDefinesDefaultView [

	| settings view |
	settings := PtySettings new.
	
	view := settings preferredViewFor: tool.
	
	view should not be: nil
]
