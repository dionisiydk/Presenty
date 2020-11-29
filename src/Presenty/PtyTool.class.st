Class {
	#name : #PtyTool,
	#superclass : #Object,
	#instVars : [
		'panel'
	],
	#category : #'Presenty-Tools'
}

{ #category : #controlling }
PtyTool >> attachToPanel [
	self subclassResponsibility 
]

{ #category : #controlling }
PtyTool >> detachFromPanel [
	self subclassResponsibility 
]
