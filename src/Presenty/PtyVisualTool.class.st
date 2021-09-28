Class {
	#name : #PtyVisualTool,
	#superclass : #PtyTool,
	#instVars : [
		'view'
	],
	#category : #'Presenty-Tools'
}

{ #category : #testing }
PtyVisualTool class >> isAbstract [ 
	^self = PtyVisualTool 
]

{ #category : #initialization }
PtyVisualTool >> chooseDefaultViewIn: aViewLibrary [
	self subclassResponsibility 
]

{ #category : #accessing }
PtyVisualTool >> view [
	^ view
]

{ #category : #accessing }
PtyVisualTool >> view: anObject [
	view := anObject
]
