Class {
	#name : #PtyCompositePresenter,
	#superclass : #PtyPresenter,
	#category : #'Presenty-Core'
}

{ #category : #accessing }
PtyCompositePresenter class >> defaultView [ 
	^PtyViewContainer new
]
