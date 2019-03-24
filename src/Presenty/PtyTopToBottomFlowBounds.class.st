Class {
	#name : #PtyTopToBottomFlowBounds,
	#superclass : #PtyFlowBounds,
	#category : #'Presenty-UI'
}

{ #category : #testing }
PtyTopToBottomFlowBounds >> containsFullMorph: aMorph [

	^aMorph bottom <= bounds bottom
]

{ #category : #accessing }
PtyTopToBottomFlowBounds >> extentWithout: aPoint [ 
	| extent |
	extent := bounds extent.
	^extent x @ (extent y  - aPoint y)
]

{ #category : #accessing }
PtyTopToBottomFlowBounds >> move: aMorph direction: aPoint [
	
	| newPosition |
	newPosition :=  aMorph position x @ (aMorph position y + aPoint y ).
	newPosition := newPosition max: aMorph owner position.
	newPosition := newPosition min: aMorph owner bottomLeft - (0 @ aMorph extent y).
	
	aMorph position: newPosition.
]

{ #category : #accessing }
PtyTopToBottomFlowBounds >> setSize: aPoint for: aMorph [
	aMorph height: aPoint y
]
