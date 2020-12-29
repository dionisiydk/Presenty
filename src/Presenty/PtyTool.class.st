Class {
	#name : #PtyTool,
	#superclass : #Object,
	#instVars : [
		'panel'
	],
	#category : #'Presenty-Tools'
}

{ #category : #testing }
PtyTool class >> isAbstract [ 
	^self = PtyTool 
]

{ #category : #controlling }
PtyTool >> assignToPanel: aPanel [

	panel := aPanel
]

{ #category : #controlling }
PtyTool >> attachToPanel [
	self subclassResponsibility 
]

{ #category : #controlling }
PtyTool >> detachFromPanel [
	self subclassResponsibility 
]
