Class {
	#name : #PtyPharoWindowDisplayDevice,
	#superclass : #PtyDisplayDevice,
	#instVars : [
		'window',
		'mainPanel'
	],
	#category : #'Presenty-Devices'
}

{ #category : #initialization }
PtyPharoWindowDisplayDevice >> initialize [ 
	super initialize.
	
	mainPanel := PtyContainerMorph new
]

{ #category : #accessing }
PtyPharoWindowDisplayDevice >> mainPanel [
	^ mainPanel
]

{ #category : #accessing }
PtyPharoWindowDisplayDevice >> mainPanel: anObject [
	mainPanel := anObject
]

{ #category : #controlling }
PtyPharoWindowDisplayDevice >> openWindow [ 
	window := mainPanel openInWindowLabeled: 'Presenty'.
	window model: self	
]

{ #category : #controlling }
PtyPharoWindowDisplayDevice >> showPanel: aPanel [ 
	mainPanel removeAllMorphs.
	mainPanel addMorph: aPanel view
]
