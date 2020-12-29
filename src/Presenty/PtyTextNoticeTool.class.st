Class {
	#name : #PtyTextNoticeTool,
	#superclass : #PtyNoticeTool,
	#instVars : [
		'label'
	],
	#category : #'Presenty-Tools'
}

{ #category : #accessing }
PtyTextNoticeTool class >> label: aString [
	^self new 
		label: aString
]

{ #category : #controlling }
PtyTextNoticeTool >> attachToPanel [
	view := panel configureViewForTool: self.
	view contents: label.
	panel placeTool: self
]

{ #category : #initialization }
PtyTextNoticeTool >> chooseDefaultViewIn: aViewLibrary [
	^aViewLibrary labelView
]

{ #category : #accessing }
PtyTextNoticeTool >> label [
	^ label
]

{ #category : #accessing }
PtyTextNoticeTool >> label: anObject [
	label := anObject
]
