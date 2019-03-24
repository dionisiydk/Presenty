Class {
	#name : #PtyLeftToRightFlowBounds,
	#superclass : #PtyFlowBounds,
	#category : #'Presenty-UI'
}

{ #category : #testing }
PtyLeftToRightFlowBounds >> containsFullMorph: aMorph [

	^aMorph right <= bounds right
]

{ #category : #accessing }
PtyLeftToRightFlowBounds >> extentWithout: aPoint [ 
	| extent |
	extent := bounds extent.
	^extent x - aPoint x @ extent y
]

{ #category : #accessing }
PtyLeftToRightFlowBounds >> move: aMorph direction: aPoint [

	| newPosition |
	newPosition :=  aMorph position x + aPoint x @ aMorph position y.
	newPosition := newPosition max: aMorph owner position.
	newPosition := newPosition min: aMorph owner topRight - (aMorph extent x @ 0).
	
	aMorph position: newPosition.
	

]

{ #category : #accessing }
PtyLeftToRightFlowBounds >> setSize: aPoint for: aMorph [
	
	aMorph width: aPoint x
]
